import React, { useState, useEffect } from 'react';
import Snackbar from '@material-ui/core/Snackbar';
import SnackbarContent from '@material-ui/core/SnackbarContent';
// import ErrorIcon from '@material-ui/icons/Error';
import ErrorOutlineIcon from '@material-ui/icons/ErrorOutline';
import { red } from '@material-ui/core/colors';

import { connect } from 'react-redux';
import { errorToBeCleared } from '../../reducers/errorReducer';
import { selectAllErrorsMapped } from '../../store'; 

const snackbarStyle = {
  backgroundColor: red[700],
}

const messageStyle = {
  display: 'flex',
  alignItems: 'center',
  fontWeight: 'bold',
}

const iconStyle = {
  fontSize: 20,
  opacity: 0.9,
  marginRight: '10px',
}

export function ErrorSnackbar(props) {
  const { errors, clearError, children } = props;
  const [open, setOpen] = useState(false);

  useEffect(() => {
    errors.length === 0 ? setOpen(false) : setOpen(true);
  }, [errors]);

  return (
    <div>
      { children }
      {
        errors.map((error, index) => (
            <Snackbar
              key={`snackbar_${error.id}_${index}`}
              anchorOrigin={{
              vertical: "bottom",
              horizontal: "left",
              }}
              open={open}
              autoHideDuration={6000}
              onClose={() => { clearError(error.id); }}
            >
              <SnackbarContent
                aria-describedby="client-snackbar"
                style={snackbarStyle}
                message={
                  <span id="client-snackbar" style={messageStyle}>
                    <ErrorOutlineIcon style={iconStyle} />
                    {error.userMessage}
                  </span>
                }
              />
            </Snackbar>
          )
        )
      }
    </div>
  );
}

const mapStateToProps = state => ({
  errors: selectAllErrorsMapped(state),
});

const mapDispatchToProps = dispatch => ({
  clearError: id => dispatch(errorToBeCleared(id)),
});

export default connect(
  mapStateToProps,
  mapDispatchToProps,
)(ErrorSnackbar);