import React from 'react';
import PropTypes from 'prop-types';
import { makeStyles } from '@material-ui/core/styles';
import Container from '@material-ui/core/Container';
import Typography from '@material-ui/core/Typography';
import Link from '@material-ui/core/Link';


const useStyles = makeStyles(theme => ({
  footer: {
    backgroundColor: theme.palette.background.paper,
    // marginTop: theme.spacing(8),
    padding: theme.spacing(6, 0),
  },
}));

const Footer = (props) => {
  const classes = useStyles();
  const { description, title } = props;

  return (
    <footer className={classes.footer}>
      <Container maxWidth="xl">
        <div className="footer1 row">
            <div className="col-sm-4">
                <div>
                    <a href="/home">
                        <img src={require("../../images/logo.png")} alt="" style={{ width: "50px", verticalAlign: "unset" }} />
                        <span className="footer-blue">Blue</span><span className="footer-orange">Ribons</span>
                    </a>
                </div>
            </div>
            <div className="col-sm-5" style={{ textAlign: "right", marginTop: "20px", color: "#ddd" }}>
                <div className="lang-wrap">
                    <div className="show-lang" style={{ color: "#000" }}><span>Careers</span></div>
                </div>
                <div className="lang-wrap">
                    <div className="show-lang" style={{ color: "#000" }} onClick={() => props.history.push("/faq")}><span>FAQs</span></div>
                </div>
                <div className="lang-wrap">
                    <div className="show-lang" style={{ color: "#000" }}><span>Blog</span></div>
                </div>
                <div className="lang-wrap">
                    <div className="show-lang" style={{ color: "#000" }} onClick={() => props.history.push("/about")}><span>About</span></div>
                </div>
            </div>
            <div className="col-sm-3" style={{ color: "#555", textAlign: "right", marginTop: "30px" }}> Copyrights©2020<a href="/home" style={{ color: "#002e6e" }}>BlueRibons.Pvt.Ltd.</a>
            </div>
        </div>
      </Container>
    </footer>
  );
}

Footer.propTypes = {
  description: PropTypes.string,
  title: PropTypes.string,
};

export default Footer