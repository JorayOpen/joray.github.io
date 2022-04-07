---
layout: post
category : Pyramid
title: Pyramid
tagline: ""
tags : [Python, Pyramid]
---
{% include JB/setup %}




        WINDOWS 
        CMD.EXE

        python 路径添加环境变量
        git 路径添加环境变量

        D:\Program Files\Python36\Scripts\;
        D:\Program Files\Python36\;
        C:\Program Files\Git\bin


---------------

        python setup.py install
        
        setup.py
        project
        ├── models
        │   ├── __init__.py
        │   └── meta.py
        ├── views
        │   ├── 
        │   └──
        ├── scripts
        │   ├── 
        │   └──
        ├── static
        │   ├── 
        │   └──
        ├── templates
        │   ├── 
        │   └──
        ├── services
        │   ├── 
        │   └──
        └──routes.py

------------

        SET PATH=D:\Program Files\Python 3.6;%PATH%
        SET VENV=D:\Application\blogr_tutorial\env
        python -m venv %VENV%
        env\Scripts\pip install "pyramid==1.9.1"
        env\Scripts\pip install cookiecutter
        env\Scripts\pip install passlib        

        D:\>cd D:\Application\blogr_tutorial
        D:\Application\blogr_tutorial>cookiecutter gh:Pylons/pyramid-cookiecutter-alchemy --checkout 1.9-branch
                
        You've downloaded C:\Users\Joray\.cookiecutters\pyramid-cookiecutter-alchemy before. Is it okay to delete and re-download it? [yes]: y
        project_name [Pyramid Scaffold]: pyramid_blogr
        repo_name [pyramid_blogr]: pyramid_blogr

        ===============================================================================
        Documentation: https://docs.pylonsproject.org/projects/pyramid/en/latest/
        Tutorials:     https://docs.pylonsproject.org/projects/pyramid_tutorials/en/latest/
        Twitter:       https://twitter.com/PylonsProject
        Mailing List:  https://groups.google.com/forum/#!forum/pylons-discuss
        Welcome to Pyramid.  Sorry for the convenience.
        ===============================================================================

        Change directory into your newly created project.
            cd pyramid_blogr

        Create a Python virtual environment.
            py -3 -m venv env

        Upgrade packaging tools.
            env\Scripts\pip install --upgrade pip setuptools

        Install the project in editable mode with its testing requirements.
            env\Scripts\pip install -e ".[testing]"

        Configure the database:
            env\Scripts\initialize_pyramid_blogr_db development.ini

        Run your project's tests.
            env\Scripts\pytest

        Run your project.
            env\Scripts\pserve development.ini
