FROM python:3.4-slim

RUN apt-get update && apt-get install -y  sqlite3 \
                    npm \
                    gettext \
                    gcc

RUN pip install --upgrade pip

RUN pip install beautifulsoup4==4.4.1 \
				boxed==0.3.0 \
				bs4==0.0.1 \
				decorator==4.0.9 \
				Django==1.9.5 \
				django-address==0.1.5 \
				django-annoying==0.9.0 \
				django-appconf==1.0.1 \
				django-autoslug==1.9.3 \
				django-bower==5.1.0 \
				django-compressor==2.0 \
				django-debug-toolbar==1.4 \
				django-extensions==1.6.1 \
				django-guardian==1.4.1 \
				django-jinja==2.1.2 \
				django-model-utils==2.4 \
				django-modelcluster==1.1 \
				django-picklefield==0.3.2 \
				django-taggit==0.18.0 \
				django-treebeard==4.0 \
				django-userena==2.0.1 \
				django-viewpack==0.1.2 \
				djangorestframework==3.3.3 \
				djinga==1.1.7 \
				easy-thumbnails==2.3 \
				ejudge==0.3.7 \
				frozendict==0.6 \
				fake-factory==0.5.7 \
				html2text==2014.12.29 \
				html5lib==0.9999999 \
				iospec==0.2.3 \
				ipython==4.1.2 \
				ipython-genutils==0.1.0 \
				Jinja2==2.8 \
				jinja2-django-tags==0.3 \
				judge==0.2.0 \
				lazy==1.2 \
				Markdown==2.6.6 \
				markio==0.1.2 \
				MarkupSafe==0.23 \
				node==0.9.16 \
				numpy==1.10.4 \
				odict==1.5.1 \
				pandas==0.18.0 \
				pexpect==4.0.1 \
				pickleshare==0.7.2 \
                Pillow==2.5.0 \
				plumber==1.3.1 \
				psutil==4.1.0 \
				ptyprocess==0.5.1 \
				pygeneric==0.5.2 \
				python-dateutil==2.5.1 \
				pytuga==0.8.4.1 \
				pytz==2016.2 \
				rcssmin==1.0.6 \
				rjsmin==1.0.12 \
				simplegeneric==0.8.1 \
				six==1.10.0 \
				sqlparse==0.1.19 \
				traitlets==4.2.1 \
				Unidecode==0.4.19  \
				wagtail==1.4.1 \
				Willow==0.3 \
				zope.component==4.2.2 \
				zope.deprecation==4.1.2 \
				zope.event==4.2.0 \
				zope.interface==4.1.3 \
				zope.lifecycleevent==4.1.0

RUN npm install -g bower

RUN apt-get install -y vim

EXPOSE 8000
