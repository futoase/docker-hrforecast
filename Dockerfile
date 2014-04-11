FROM centos
 
MAINTAINER Keiji Matsuzaki <futoase@gmail.com>

# setup network
# reference from https://github.com/dotcloud/docker/issues/1240#issuecomment-21807183
RUN echo "NETWORKING=yes" > /etc/sysconfig/network
 
# setup remi repository
RUN wget http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm
RUN wget http://rpms.famillecollet.com/enterprise/remi-release-6.rpm
RUN curl -O http://rpms.famillecollet.com/RPM-GPG-KEY-remi; rpm --import RPM-GPG-KEY-remi
RUN rpm -Uvh remi-release-6*.rpm epel-release-6*.rpm

RUN yum -y update
RUN yum -y upgrade

# installe sshd, passwd
RUN yum -y install openssh-server passwd
 
# setup nginx repository
ADD ./template/nginx.repo /etc/yum.repos.d/nginx.repo
 
# setup tools
# reference from http://blog.nomadscafe.jp/2013/12/centos-65dockergrowthforecast.html
RUN yum -y groupinstall --enablerepo=epel,remi "Development Tools"
RUN yum -y install --enablerepo=epel,remi pkgconfig glib2-devel gettext libxml2-devel pango-devel cairo-devel git ipa-gothic-fonts
RUN yum -y install --enablerepo=epel,remi mysql mysql-server mysql-devel
 
# install sshd
RUN yum -y install --enablerepo=epel,remi openssh-server openssh-client
# Change UsePAM yes to no
RUN sed -i -e 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
 
# install nginx
RUN yum -y install --enablerepo=nginx nginx

# install supervisord
RUN yum -y install --enablerepo=epel,remi supervisor
 
# setup perlbrew
RUN export PERLBREW_ROOT=/opt/perlbrew && curl -L http://install.perlbrew.pl | bash
RUN source /opt/perlbrew/etc/bashrc && perlbrew install perl-5.18.2
RUN source /opt/perlbrew/etc/bashrc && perlbrew use perl-5.18.2 && perlbrew install-cpanm

RUN useradd -m hrforecast
RUN echo "hrforecast" | passwd --stdin hrforecast
RUN mkdir -p /home/hrforecast/scripts
 
# install HRForecast
RUN git clone https://github.com/kazeburo/HRForecast.git /home/hrforecast/HRForecast
RUN source /opt/perlbrew/etc/bashrc && cd /home/hrforecast/HRForecast && perlbrew use perl-5.18.2 && cpanm -n -lextlib --installdeps .
 
# setup mysqld
ADD ./scripts/mysqld-setup.sh /home/hrforecast/scripts/mysqld-setup.sh
RUN chmod +x /home/hrforecast/scripts/mysqld-setup.sh
RUN /home/hrforecast/scripts/mysqld-setup.sh

ADD ./scripts/update-config.sh /home/hrforecast/scripts/update-config.sh
RUN chmod +x /home/hrforecast/scripts/update-config.sh
RUN /home/hrforecast/scripts/update-config.sh

# setup configration of nginx.
ADD ./template/nginx.conf /etc/nginx/conf.d/hrforecast.conf
RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/example_ssl.conf
RUN service nginx restart

# setup supervisor
RUN sed -i -e "s/nodaemon=false/nodaemon=true/g" /etc/supervisord.conf
ADD ./template/supervisord.conf /tmp/hrforecast.conf
RUN cat /tmp/hrforecast.conf >> /etc/supervisord.conf
RUN rm /tmp/hrforecast.conf

# linked log directory
RUN ln -s /var/log /tmp/log

ADD ./scripts/timezone.sh /home/hrforecast/scripts/timezone.sh
RUN chmod +x /home/hrforecast/scripts/timezone.sh
ADD ./scripts/startup.sh /home/hrforecast/scripts/startup.sh
RUN chmod +x /home/hrforecast/scripts/startup.sh
ENV PATH /opt/perlbrew/perls/perl-5.18.2/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
 
EXPOSE 22 80
CMD ["/home/hrforecast/scripts/startup.sh"]
