# Substitute your own docker index username, if you like.
DOCKER_USER=lanrat

# Change this to suit your needs.
NAME:=filebot
TAG:=filebot
DATA_DIR:=$(HOME)/media

RUNNING:=$(shell docker ps | grep $(NAME) | cut -f 1 -d ' ')
ALL:=$(shell docker ps -a | grep $(NAME) | cut -f 1 -d ' ')
DOCKER_RUN_COMMON=-v $(DATA_DIR):/data $(DOCKER_USER)/$(TAG)

all: build

build:
	docker build -t="$(DOCKER_USER)/$(TAG)" .

data_dir: 
	mkdir -p $(DATA_DIR) $(CONFIG_DIR)

run: clean data_dir
	docker run -d --name="$(NAME)" $(DOCKER_RUN_COMMON) 

bash: data_dir
	mkdir -p $(DATA_DIR) $(CONFIG_DIR)
	docker run -i -t --rm $(DOCKER_RUN_COMMON) bash -l

inspect:
ifneq ($(strip $(RUNNING)),)
	docker exec -i -t $(RUNNING) bash -l
endif

# Removes existing containers.
clean:
ifneq ($(strip $(RUNNING)),)
	docker stop $(RUNNING)
endif
ifneq ($(strip $(ALL)),)
	docker rm $(ALL)
endif

