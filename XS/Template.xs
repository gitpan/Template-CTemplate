MODULE = Template::CTemplate   PACKAGE = Template::CTemplate::Template

PROTOTYPES: ENABLE

Template *
Template::new(file, strip)
    string  file
    Strip   strip
    CODE:
        RETVAL = Template::GetTemplate(file, strip);
    OUTPUT:
      RETVAL

bool
Template::set_template_root_directory(directory);
  string directory
  CODE:
    RETVAL = Template::SetTemplateRootDirectory(directory);
  OUTPUT:
    RETVAL

void
Template::reload_all_if_changed();
  CODE:
    Template::ReloadAllIfChanged();

void
Template::clear_cache();
  CODE:
    Template::ClearCache();

string
Template::expand(dict);
  TemplateDictionary * dict
  CODE:
    string output = string();
    bool rv;
    rv = THIS->Expand(&output, dict);
    RETVAL = output;
  OUTPUT:
    RETVAL

bool
Template::reload_if_changed();
  CODE:
    THIS->ReloadIfChanged();

string
Template::template_root_directory();
  CODE:
    RETVAL = Template::template_root_directory();
  OUTPUT:
    RETVAL
   
TemplateState
Template::state();
  CODE:
    RETVAL = THIS->state();
  OUTPUT:
    RETVAL

const char *
Template::template_file();
  CODE:
    RETVAL = THIS->template_file();
  OUTPUT:
    RETVAL

string
Template::write_header_entries();
  CODE:
    string outstring = string();
    THIS->WriteHeaderEntries(&outstring);
    RETVAL = outstring;
  OUTPUT:
    RETVAL

