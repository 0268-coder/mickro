
function authenticateUser(req, res, next){
    if(!req.session.user) {
        return res.redirect("/login");
    }
    next();
}

function authenticateAdmin(req, res, next){
    if(!req.session.user.isAdmin) {
        return res.redirect("/login");
    }
    next();
}

function authenticateStaff(req,res,next){
    if(!req.session.user.isStaff){
        return res.redirect("/login");
    }
}
module.exports = { authenticateUser, authenticateAdmin, authenticateStaff };