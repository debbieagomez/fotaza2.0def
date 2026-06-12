const {DataTypes} = require('sequelize');
const sequelize = require('../config/db');

const Follower = sequelize.define('Follower', {
    follower_id: {
        type: DataTypes.INTEGER,
        primaryKey: true,
    },
    following_id: {
        type: DataTypes.INTEGER,
        primaryKey: true
    },
    created_at: {
        type: DataTypes.DATE,
        defaultValue: DataTypes.NOW
    }
}, {tableName: 'followers', 
        timestamps: false,
        validate: {
            notSelfFollow() {
                if (this.follower_id === this.following_id) {
                    throw new Error('Un usuario no puede seguirse a si mismo ');

                }
            }
        }
    }
);

module.exports = Follower;