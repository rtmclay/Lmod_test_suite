VERSION_SRC := .version
VCMD        := tools/version_cmd
VDATE       := $(shell date +'%F %H:%M %:z')
gittag:
        ifneq ($(TAG),)
	  @git status -s > /tmp/git_st_$$$$;                                         \
          if [ -s /tmp/git_st_$$$$ ]; then                                           \
	    echo "All files not checked in => try again";                            \
	  else                                                                       \
	    $(RM)                                                    $(VCMD);        \
	    $(RM)                                                    $(VERSION_SRC); \
	    echo '$(TAG)'                                         >  $(VERSION_SRC); \
	    echo '#!/usr/bin/env lua'                             >  $(VCMD); 	     \
	    echo 'function tag()  return "$(TAG)"   end'          >  $(VCMD); 	     \
	    echo 'function date() return "$(VDATE)" end'          >> $(VCMD); 	     \
	    echo 'function main()'                                >> $(VCMD); 	     \
            echo '  local a = {}'                                 >> $(VCMD); 	     \
	    echo '  a[#a+1] = tag()'                              >> $(VCMD); 	     \
	    echo '  a[#a+1] = date()'                             >> $(VCMD); 	     \
	    echo '  local s = table.concat(a," ")'                >> $(VCMD); 	     \
	    echo '  print("Lmod test suite: Version "..s)'        >> $(VCMD); 	     \
	    echo 'end'                                            >> $(VCMD); 	     \
	    echo 'main()'                                         >> $(VCMD); 	     \
            git commit -m "moving to TAG_VERSION $(TAG)"             $(VERSION_SRC); \
            git tag -a $(TAG) -m 'Setting TAG_VERSION to $(TAG)'                   ; \
	    branchName=`git status | head -n 1 | sed 's/^[# ]*On branch //g'`      ; \
            git push        origin $$branchName                                    ; \
	    git push --tags origin $$branchName                                    ; \
          fi;                                                                        \
          rm -f /tmp/git_st_$$$$
        else
	  @echo "To git tag do: make gittag TAG=?"
        endif

world_update:
	@git status -s > /tmp/git_st_$$$$;                                         \
        if [ -s /tmp/git_st_$$$$ ]; then                                           \
            echo "All files not checked in => try again";                          \
        else                                                                       \
	    branchName=`git status | head -n 1 | sed 's/^[# ]*On branch //g'`;	   \
            git push        github $$branchName;                                   \
            git push --tags github $$branchName;                                   \
        fi;                                                                        \
        rm -f /tmp/git_st_$$$$
