import React from "react";
import PropTypes from "prop-types";
import { withStyles } from "@material-ui/core/styles";
import Card from "@material-ui/core/Card";
import Grid from "@material-ui/core/Grid";
import Typography from "@material-ui/core/Typography";

const styles = {
  card: {
    minWidth: 275,
    marginTop: "100px"
  },
  bullet: {
    display: "inline-block",
    margin: "0 2px",
    transform: "scale(0.8)"
  },
  title: {
    fontSize: 25,
    padding: "10px"
  },
  pos: {
    marginBottom: 12
  }
};

function Page404(props) {
  const { classes } = props;

  return (
    <Grid container>
      <Grid item xs={4} />
      <Grid item xs={4} style={{ textAlign: "center" }}>
        <Card className={classes.card}>
          <Typography
            className={classes.title}
            color="textPrimary"
            gutterBottom
          >
            <h1>404</h1>
            <b>Page Not Found</b>
          </Typography>
        </Card>
      </Grid>
    </Grid>
  );
}

Page404.propTypes = {
  classes: PropTypes.object.isRequired
};

export default withStyles(styles)(Page404);
