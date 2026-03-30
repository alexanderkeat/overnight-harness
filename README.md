This is an independently operating harness meant to be provided one command, after which it will execute all development phases that have been provided to it.

Required documents:

/product-context #use this naming convention for the folder holding the files

  -architecture.md #holds the technical architecture for the entire build

  -user-stories.md #holds all of the stories for this particular build, fully written out.
  
  -build-phases.md #holds all of the phases for development in this run
  
  -PRD.md #holds the entire PRD for the entire product.
  
  /UX-UI #optional - use if you have ux/ui structures
  
  /phases
  
    -phase-01.md #the particular requirements for that phase. Should include: Title, Status: not started, Goal, Deliverables, Acceptance Criteria, Related User Stories (full copies), Architecture References
    
    -phase-02.md
    
    -phase-03.md


To start the run:
1. Ask claude to clone in this harness, replacing whatever claude.md file you have.
2. Check the file schema to be sure the clone in was successful.
3. Ask claude to check if it has all of the mcp servers, cli's, etc. to be able to run the build or if it needs further configuration.
4. Clear context
5. Start the run by saying something like "Begin to build the project. Important!! Use the Claude.md file and all skills. Be slow, methodical and run each step of each phase without skipping. Use all skills provided."
6. OPTIONAL - IF YOU'D LIKE A LOG OF THE BUILD: "Begin to build the project following the loop in Claude.md file and all skills. Be slow, methodical and run each step of each phase without skipping. The purpose of the build is to ensure all the skills work well together. Thus, at the end, add a “skill-use-log.md” where you append every implementation of every skill as follows:  "PhaseNumber", "SkillInvoked", "ByWhom", "Outcome" as a new row in a table. After, we will analyze the table.
