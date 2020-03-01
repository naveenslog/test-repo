import React, { useState } from "react";
import { FAQS } from '../../helpers/constants';

const FAQs = (props) => {
    return (
        <div className="faq-container">
            <div className="page-header">
                <h1 className="h2">Frequently Asked Questions</h1>
            </div>
            <div className="faq-details">
                <p>
                    <ol style={{ fontWeight: "400" }}>
                        {FAQS.map(item => <React.Fragment><li>{item.que}</li><span>{item.ans}</span></React.Fragment>)}
                    </ol>
                </p>
            </div>
        </div>
    )
}
export default FAQs