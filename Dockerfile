FROM jupyter/tensorflow-notebook:python-3.11

WORKDIR /home/jovyan/work

# Python packages
RUN pip install \
  plotly==5.8.0 \
  plotly-geo==1.0.0 \
  pymongo==4.1.1 \
  python-dotenv==0.19.1 \
  jupyter-contrib-nbextensions==0.5.1 \
  pylantern==0.1.6 \
  qgrid==1.3.1 \
  pandas-profiling==3.0.0 \
  SQLAlchemy==1.4.37 \
  pytest==6.2.2 \
  streamlit==1.10.0 \
  streamlit-aggrid==0.2.3 \
  simplejson==3.17.2 && \
  kaleido==1.0.0 \
  fix-permissions $CONDA_DIR && \
  fix-permissions /home/$NB_USER

USER root

USER jovyan

RUN mkdir /home/jovyan/work/notebooks

WORKDIR /home/jovyan/work/notebooks

CMD ["jupyter", "lab"]
