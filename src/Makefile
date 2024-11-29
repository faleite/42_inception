NAME := inception
COMP:= docker compose
FILE:= srcs/docker-compose.yml

all: $(NAME)

$(NAME): prune
	@echo "$(PURPLE)====================================$(CLR_RESET)"
	@echo "$(GREEN)Composing the $(BLUE)$(NAME) $(GREEN)project...$(CLR_RESET)"
	@ $(COMP) -f $(FILE) up --build
	@echo "$(BLUE)$(NAME) $(GREEN)is ready!$(CLR_RESET)"
	@echo "$(PURPLE)====================================$(CLR_RESET)"

prune:
	@echo "$(PURPLE)====================================$(CLR_RESET)"
	@echo "$(YELLOW)Pruning the $(BLUE)Docker system...$(CLR_RESET)"
	@ docker system prune -f
	@echo "$(BLUE)Docker system is clean!$(CLR_RESET)"
	@echo "$(PURPLE)====================================$(CLR_RESET)"

down:
	@echo "$(PURPLE)====================================$(CLR_RESET)"
	@echo "$(RED)Stopping the $(BLUE)$(NAME) $(RED)project...$(CLR_RESET)"
	@ $(COMP) -f $(FILE) down -v
	@echo "$(BLUE)$(NAME) $(RED)is down!$(CLR_RESET)"
	@echo "$(PURPLE)====================================$(CLR_RESET)"

start:
	@ $(COMP) -f $(FILE) start

stop:
	@ $(COMP) -f $(FILE) stop

restart:
	@ $(COMP) -f $(FILE) restart

ps:
	@ $(COMP) -f $(FILE) ps

logs:
	@ $(COMP) -f $(FILE) logs -f

domain:
	@ echo "127.0.0.1 faaraujo.42.fr" >> /etc/hosts

.PHONY: all inception prune down start stop restart ps logs domain

# COLORS
CLR_RESET	= \033[0m
RED		    = \033[1;31m
GREEN		= \033[1;32m
YELLOW		= \033[1;33m
BLUE		= \033[1;34m
PURPLE 		= \033[0;35m