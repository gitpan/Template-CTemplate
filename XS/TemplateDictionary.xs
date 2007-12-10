MODULE = Template::CTemplate   PACKAGE = Template::CTemplate::Dictionary

PROTOTYPES: ENABLE

TemplateDictionary *
TemplateDictionary::new(name)
    string  name
    CODE:
        RETVAL = new TemplateDictionary(name, NULL);
    OUTPUT:
      RETVAL

TemplateDictionary *
TemplateDictionary::clone(name)
  string name
  CODE:
    RETVAL = THIS->MakeCopy(name, NULL);
  OUTPUT:
    RETVAL

string
TemplateDictionary::name()
  CODE:
    RETVAL = THIS->name();
  OUTPUT:
    RETVAL

void
TemplateDictionary::set_value(variable, value)
  string variable
  string value
  CODE:
    THIS->SetValue(variable, value);

void
TemplateDictionary::set_global_value(variable, value)
  string variable
  string value
  CODE:
    TemplateDictionary::SetGlobalValue(variable, value);

void
TemplateDictionary::set_int_value(variable, value)
  string variable
  int value
  CODE:
    THIS->SetIntValue(variable, value);

void
TemplateDictionary::set_template_global_value(variable, value);
  string variable
  string value
  CODE:
    THIS->SetTemplateGlobalValue(variable, value);

TemplateDictionary *
TemplateDictionary::add_section_dictionary(section_name);
  string section_name
  CODE:
    RETVAL = THIS->AddSectionDictionary(section_name);
  OUTPUT:
    RETVAL

void
TemplateDictionary::set_value_and_show_section(variable, value, section_name);
  string variable
  string value
  string section_name
  CODE:
    THIS->SetValueAndShowSection(variable, value, section_name);

TemplateDictionary *
TemplateDictionary::add_include_dictionary(variable);
  string variable
  CODE:
    RETVAL = THIS->AddIncludeDictionary(variable);
  OUTPUT:
    RETVAL

void
TemplateDictionary::show_section(name)
  string name
  CODE:
    THIS->ShowSection(name);

void
TemplateDictionary::dump(indent)
  int indent
  CODE:
    THIS->Dump(indent);

string
TemplateDictionary::dump_to_string(indent)
  int indent
  CODE:
    string str = string();
    THIS->DumpToString( &str, indent );
    RETVAL = str;
  OUTPUT:
    RETVAL

