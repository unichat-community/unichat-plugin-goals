/*!******************************************************************************
 * Copyright (c) 2026 Voguh
 *
 * This program and the accompanying materials are made
 * available under the terms of the Eclipse Public License 2.0
 * which is available at https://www.eclipse.org/legal/epl-2.0/
 *
 * SPDX-License-Identifier: EPL-2.0
 ******************************************************************************/


const DONATION_GOAL_AMOUNT_STORED_KEY = "plugin-goals:donation_goal_amount";
const DONATION_GOAL_TARGET_STORED_KEY = "plugin-goals:donation_goal_target";


/* ========================================================================== */

const MAIN_CONTAINER = document.querySelector("#main-container");
const PROGRESS_BAR = MAIN_CONTAINER.querySelector(".progress-bar .progress");

let donationGoalAmount = 0;
let donationGoalTarget = 1000;

/* ========================================================================== */

function updateDisplay() {
    const percentage = Math.max(Math.min((donationGoalAmount / donationGoalTarget) * 100, 100), 0);
    PROGRESS_BAR.style.width = `${percentage}%`;
}

function debouncedUpdateDisplay() {
    clearTimeout(debouncedUpdateDisplay.timeout);
    debouncedUpdateDisplay.timeout = setTimeout(updateDisplay, 100);
}

/* ========================================================================== */

window.addEventListener("unichat:connected", function ({ detail: { userstore } }) {
    globalThis.UNICHAT_USERSTORE = userstore;

    let storedDonationGoalAmount = parseFloat(userstore[DONATION_GOAL_AMOUNT_STORED_KEY]);
    if (!Number.isNaN(storedDonationGoalAmount)) {
        donationGoalAmount = storedDonationGoalAmount;
    }

    let storedDonationGoalTarget = parseFloat(userstore[DONATION_GOAL_TARGET_STORED_KEY]);
    if (!Number.isNaN(storedDonationGoalTarget)) {
        donationGoalTarget = storedDonationGoalTarget;
    }

    requestAnimationFrame(debouncedUpdateDisplay);
});

window.addEventListener("unichat:event", function ({ detail: event }) {
    // Nothing...
});

window.addEventListener("unichat:userstore_update", function ({ detail: { key, value } }) {
    switch (key) {
        case DONATION_GOAL_AMOUNT_STORED_KEY: {
            let parsedValue = parseFloat(value);
            if (!Number.isNaN(parsedValue)) {
                donationGoalAmount = parsedValue;
            }
            break;
        }
        case DONATION_GOAL_TARGET_STORED_KEY: {
            let parsedValue = parseFloat(value);
            if (!Number.isNaN(parsedValue)) {
                donationGoalTarget = parsedValue;
            }
            break;
        }
    }

    requestAnimationFrame(debouncedUpdateDisplay);
});
