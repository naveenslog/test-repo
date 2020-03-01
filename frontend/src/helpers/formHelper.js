/* eslint-disable react/prop-types */
import R from 'ramda';
import React from 'react';
import TextField from 'material-ui/TextField';
import { FormControl, FormHelperText } from 'material-ui/Form';
import DateRange from 'material-ui-icons/DateRange';
import Typography from 'material-ui/Typography';
import FieldLabelWithTooltipIcon from '../components/common/fieldLabelWithTooltip';
import { formatDateForPrint } from './dates';
import InputLabel from '@material-ui/core/InputLabel';
import Select from "@material-ui/core/Select";
import RadioGroup from '@material-ui/core/RadioGroup';

export const fileNameFromUrl = (url) => {
  if (url) {
    return url.split('?')[0].split('/').pop();
  }

  return '-';
};

export const renderPasswordField = ({
  name,
  className,
  meta: { touched, error, warning },
  input,
  label,
  infoText,
  formControlStyle,
  ...other
}) => (
  <FormControl fullWidth style={formControlStyle}>
    <FieldLabelWithTooltipIcon
      infoText={infoText}
      tooltipIconProps={{
        name: input.name,
      }}
    >
      {label}
    </FieldLabelWithTooltipIcon>
    <TextField
      className={className}
      id={input.name}
      error={(touched && !!error) || !!warning}
      fullWidth
      {...input}
      {...other}
    />
    <div style={{ display: 'flex', alignItems: 'center', justifyContent: 'space-between' }}>
      {((touched && error) || warning) && <FormHelperText error>{error || warning}</FormHelperText>}
    </div>
  </FormControl>);

export const renderText = ({
  className,
  input,
  values,
  optional,
  label,
  infoText,
  date,
  meta,
  multiline,
  inputProps,
  InputProps,
  ...other
}) => {
  let value = (!R.isNil(input.value) && !R.isEmpty(input.value))
    ? input.value
    : (InputProps
      ? InputProps.inputProps.initial
      : null);

  if (!value) value = '-';

  if (values) {
    value = R.filter((val) => {
      if (Array.isArray(value)) return value.includes(val.value);
      return value === val.value;
    }, values).map(matchedValue => matchedValue.label).join(', ');
  }

  if (R.isEmpty(value) || R.isNil(value)) {
    value = (!R.isNil(input.value) && !R.isEmpty(input.value))
      ? input.value
      : (InputProps
        ? InputProps.inputProps.initial
        : null);
  }
  if (date) value = formatDateForPrint(value);
  if (R.isEmpty(value) || R.isNil(value)) value = '-';

  return (
    <FormControl fullWidth>
      {label && <FieldLabelWithTooltipIcon
        infoText={infoText}
        tooltipIconProps={{
          name: input.name,
        }}
      >
        {label}
      </FieldLabelWithTooltipIcon>}
      <div style={{ display: 'flex', alignItems: 'center' }}>
        {date && <DateRange style={{
          marginRight: 5,
          width: 22,
          height: 22,
        }}
        />}
        <Typography
          className={className}
          style={{ whiteSpace: 'pre-wrap' }}
          {...other}
        >
          {Array.isArray(value) ? value.join(', ') : value}
        </Typography>
      </div>
    </FormControl>
  );
};

export const renderTextArea =({
  label, 
  className, 
  margin, 
  input, 
  meta: { touched, invalid, error },
  ...custom
}) => {
  return (
    <TextField
      id="outlined-multiline-flexible"
      label={label}
      multiline
      rows={6}
      rowsMax={10}
      fullWidth
      margin="normal"
      variant="outlined"
      InputLabelProps={{
        shrink: true,
      }}
      error={touched && invalid}
      helperText={touched && error}
      {...input}
      {...custom}
    />
  )
};

export const renderMultiSelectField = ({
  input,
  label,
  children,
  className,
  inputClass,
  options,
  handleChange,
  margin,
  MenuProps,
  ...custom
}) => (
  <FormControl className={className} margin={margin}>
    <InputLabel htmlFor="select-multiple" shrink={true} className={inputClass}>{label}</InputLabel>
    <Select
      multiple
      value={options}
      onChange={handleChange}
      className={className}
      {...custom}
    >
      {children}
    </Select>
  </FormControl>
);

export const renderRadioField = ({
  margin,
  className,
  handleChange,
  children,
  input
}) => (
  <FormControl component="fieldset" className={className} margin={margin}>
    <RadioGroup aria-label="position" onChange={handleChange} row {...input}>
      {children}
    </RadioGroup>
  </FormControl>
);
