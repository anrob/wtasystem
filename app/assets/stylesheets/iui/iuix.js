(function(){var _1=20;var _2=0;var _3=30000;var _4=null;var _5=null;var _6=0;var _7=0;var _8=location.hash;var _9="#_";var _a=[];var _b=0;var _c;var _d=false;var _e="portrait";var _f="landscape";window.iui={busy:false,animOn:true,ajaxErrHandler:null,httpHeaders:{"X-Requested-With":"XMLHttpRequest"},showPage:function(_10,_11){if(_10){if(_10==_4){console.log("page = currentPage = "+_10.id);iui.busy=false;return;}if(_5){_5.removeAttribute("selected");sendEvent("blur",_5);_5=null;}if(hasClass(_10,"dialog")){iui.busy=false;sendEvent("focus",_10);showDialog(_10);}else{sendEvent("load",_10);var _12=_4;sendEvent("blur",_4);_4=_10;sendEvent("focus",_10);if(_12){setTimeout(slidePages,0,_12,_10,_11);}else{updatePage(_10,_12);}}}},showPageById:function(_13){var _14=$(_13);if(_14){if(!iui.busy){iui.busy=true;var _15=_a.indexOf(_13);var _16=_15!=-1;if(_16){_a.splice(_15);}iui.showPage(_14,_16);}}},goBack:function(){if(!iui.busy){iui.busy=true;_a.pop();var _17=_a.pop();var _18=$(_17);iui.showPage(_18,true);}},replacePage:function(_19){var _1a=$(_19);if(_1a){if(!iui.busy){iui.busy=true;var _1b=_a.indexOf(_19);var _1c=_1b!=-1;if(_1c){console.log("error: can't replace page with ancestor");}_a.pop();iui.showPage(_1a,false);}}},showPageByHrefExt:function(_1d,_1e,_1f,_20,cb){if(!iui.busy){iui.busy=true;iui.showPageByHref(_1d,_1e,_1f,_20,cb);}},showPageByHref:function(_22,_23,_24,_25,cb){function spbhCB(xhr){console.log("xhr.readyState = "+xhr.readyState);if(xhr.readyState==4){if((xhr.status==200||xhr.status==0)&&!xhr.aborted){var _28=document.createElement("div");_28.innerHTML=xhr.responseText;sendEvent("beforeinsert",document.body,{fragment:_28});if(_25){replaceElementWithFrag(_25,_28);iui.busy=false;}else{iui.insertPages(_28);}}else{iui.busy=false;if(iui.ajaxErrHandler){iui.ajaxErrHandler("Error contacting server, please try again later");}}if(cb){setTimeout(cb,1000,true);}}}iui.ajax(_22,_23,_24,spbhCB);},ajax:function(url,_2a,_2b,cb){var xhr=new XMLHttpRequest();_2b=_2b?_2b.toUpperCase():"GET";if(_2a&&_2b=="GET"){url=url+"?"+iui.param(_2a);}xhr.open(_2b,url,true);if(cb){xhr.onreadystatechange=function(){cb(xhr);};}var _2e=null;if(_2a&&_2b!="GET"){xhr.setRequestHeader("Content-Type","application/x-www-form-urlencoded");_2e=iui.param(_2a);}for(var _2f in iui.httpHeaders){xhr.setRequestHeader(_2f,iui.httpHeaders[_2f]);}xhr.send(_2e);xhr.requestTimer=setTimeout(ajaxTimeout,_3);return xhr;function ajaxTimeout(){try{xhr.abort();xhr.aborted=true;}catch(err){console.log(err);}}},param:function(o){var s=[];for(var key in o){s[s.length]=encodeURIComponent(key)+"="+encodeURIComponent(o[key]);}return s.join("&").replace(/%20/g,"+");},insertPages:function(_33){var _34=_33.childNodes;var _35;for(var i=0;i<_34.length;++i){var _37=_34[i];if(_37.nodeType==1){if(!_37.id){_37.id="__"+(++_b)+"__";}var _38=$(_37.id);var _39;if(_38){_38.parentNode.replaceChild(_37,_38);_39=$(_37.id);}else{_39=document.body.appendChild(_37);}sendEvent("afterinsert",document.body,{insertedNode:_39});if(_37.getAttribute("selected")=="true"||!_35){_35=_37;}--i;}}sendEvent("afterinsertend",document.body,{fragment:_33});if(_35){iui.showPage(_35);}},getSelectedPage:function(){for(var _3a=document.body.firstChild;_3a;_3a=_3a.nextSibling){if(_3a.nodeType==1&&_3a.getAttribute("selected")=="true"){return _3a;}}},getAllViews:function(){return document.querySelectorAll("body > *:not(.toolbar)");},isNativeUrl:function(_3b){for(var i=0;i<iui.nativeUrlPatterns.length;i++){if(_3b.match(iui.nativeUrlPatterns[i])){return true;}}return false;},nativeUrlPatterns:[new RegExp("^http://maps.google.com/maps?"),new RegExp("^mailto:"),new RegExp("^tel:"),new RegExp("^http://www.youtube.com/watch\\?v="),new RegExp("^http://www.youtube.com/v/"),new RegExp("^javascript:"),],hasClass:function(_3d,_3e){var re=new RegExp("(^|\\s)"+_3e+"($|\\s)");return re.exec(_3d.getAttribute("class"))!=null;},addClass:function(_40,_41){if(!iui.hasClass(_40,_41)){_40.className+=" "+_41;}},removeClass:function(_42,_43){if(iui.hasClass(_42,_43)){var reg=new RegExp("(\\s|^)"+_43+"(\\s|$)");_42.className=_42.className.replace(reg," ");}}};addEventListener("load",function(_45){var _46=iui.getSelectedPage();var _47=getPageFromLoc();if(_46){iui.showPage(_46);}if(_47&&(_47!=_46)){iui.showPage(_47);}setTimeout(preloadImages,0);if(typeof window.onorientationchange=="object"){window.onorientationchange=orientChangeHandler;_d=true;setTimeout(orientChangeHandler,0);}setTimeout(checkOrientAndLocation,0);_c=setInterval(checkOrientAndLocation,300);},false);addEventListener("unload",function(_48){return;},false);addEventListener("click",function(_49){var _4a=findParent(_49.target,"a");if(_4a){function unselect(){_4a.removeAttribute("selected");}if(_4a.href&&_4a.hash&&_4a.hash!="#"&&!_4a.target){followAnchor(_4a);}else{if(_4a==$("backButton")){iui.goBack();}else{if(_4a.getAttribute("type")=="submit"){var _4b=findParent(_4a,"form");if(_4b.target=="_self"){_4b.submit();return;}submitForm(_4b);}else{if(_4a.getAttribute("type")=="cancel"){cancelDialog(findParent(_4a,"form"));}else{if(_4a.target=="_replace"){followAjax(_4a,_4a);}else{if(iui.isNativeUrl(_4a.href)){return;}else{if(_4a.target=="_webapp"){location.href=_4a.href;}else{if(!_4a.target&&_4a.href){followAjax(_4a,null);}else{return;}}}}}}}}_49.preventDefault();}},true);addEventListener("click",function(_4c){var div=findParent(_4c.target,"div");if(div&&hasClass(div,"toggle")){div.setAttribute("toggled",div.getAttribute("toggled")!="true");_4c.preventDefault();}},true);function followAnchor(_4e){function unselect(){_4e.removeAttribute("selected");}if(!iui.busy){iui.busy=true;_4e.setAttribute("selected","true");iui.showPage($(_4e.hash.substr(1)));setTimeout(unselect,500);}}function followAjax(_4f,_50){function unselect(){_4f.removeAttribute("selected");}if(!iui.busy){iui.busy=true;_4f.setAttribute("selected","progress");iui.showPageByHref(_4f.href,null,"GET",_50,unselect);}}function sendEvent(_51,_52,_53){if(_52){var _54=document.createEvent("UIEvent");_54.initEvent(_51,false,false);if(_53){for(i in _53){_54[i]=_53[i];}}_52.dispatchEvent(_54);}}function getPageFromLoc(){var _55;var _56=location.hash.match(/#_([^\?_]+)/);if(_56){_55=_56[1];}if(_55){_55=$(_55);}return _55;}function orientChangeHandler(){var _57=window.orientation;switch(_57){case 0:setOrientation(_e);break;case 90:case -90:setOrientation(_f);break;}}function checkOrientAndLocation(){if(!_d){if((window.innerWidth!=_6)||(window.innerHeight!=_7)){_6=window.innerWidth;_7=window.innerHeight;var _58=(_6<_7)?_e:_f;setOrientation(_58);}}if(location.hash!=_8){var _59=location.hash.substr(_9.length);iui.showPageById(_59);}}function setOrientation(_5a){document.body.setAttribute("orient",_5a);if(_5a==_e){iui.removeClass(document.body,_f);iui.addClass(document.body,_e);}else{if(_5a==_f){iui.removeClass(document.body,_e);iui.addClass(document.body,_f);}else{iui.removeClass(document.body,_e);iui.removeClass(document.body,_f);}}setTimeout(scrollTo,100,0,1);}function showDialog(_5b){_5=_5b;_5b.setAttribute("selected","true");if(hasClass(_5b,"dialog")){showForm(_5b);}}function showForm(_5c){_5c.onsubmit=function(_5d){_5d.preventDefault();submitForm(_5c);};_5c.onclick=function(_5e){if(_5e.target==_5c&&hasClass(_5c,"dialog")){cancelDialog(_5c);}};}function cancelDialog(_5f){_5f.removeAttribute("selected");}function updatePage(_60,_61){if(!_60.id){_60.id="__"+(++_b)+"__";}location.hash=_8=_9+_60.id;_a.push(_60.id);var _62=$("pageTitle");if(_60.title){_62.innerHTML=_60.title;}var _63=_60.getAttribute("ttlclass");_62.className=_63?_63:"";if(_60.localName.toLowerCase()=="form"&&!_60.target){showForm(_60);}var _64=$("backButton");if(_64){var _65=$(_a[_a.length-2]);if(_65&&!_60.getAttribute("hideBackButton")){_64.style.display="inline";_64.innerHTML=_65.title?_65.title:"Back";var _66=_65.getAttribute("bbclass");_64.className=(_66)?"button "+_66:"button";}else{_64.style.display="none";}}iui.busy=false;}function slidePages(_67,_68,_69){var _6a=(_69?_67:_68).getAttribute("axis");clearInterval(_c);sendEvent("beforetransition",_67,{out:true});sendEvent("beforetransition",_68,{out:false});if(canDoSlideAnim()&&_6a!="y"){slide2(_67,_68,_69,slideDone);}else{slide1(_67,_68,_69,_6a,slideDone);}function slideDone(){if(!hasClass(_68,"dialog")){_67.removeAttribute("selected");}_c=setInterval(checkOrientAndLocation,300);setTimeout(updatePage,0,_68,_67);_67.removeEventListener("webkitTransitionEnd",slideDone,false);sendEvent("aftertransition",_67,{out:true});sendEvent("aftertransition",_68,{out:false});if(_69){sendEvent("unload",_67);}}}function canDoSlideAnim(){return (iui.animOn)&&(typeof WebKitCSSMatrix=="object");}function slide1(_6b,_6c,_6d,_6e,cb){if(_6e=="y"){(_6d?_6b:_6c).style.top="100%";}else{_6c.style.left="100%";}scrollTo(0,1);_6c.setAttribute("selected","true");var _70=100;slide();var _71=setInterval(slide,_2);function slide(){_70-=_1;if(_70<=0){_70=0;clearInterval(_71);cb();}if(_6e=="y"){_6d?_6b.style.top=(100-_70)+"%":_6c.style.top=_70+"%";}else{_6b.style.left=(_6d?(100-_70):(_70-100))+"%";_6c.style.left=(_6d?-_70:_70)+"%";}}}function slide2(_72,_73,_74,cb){_73.style.webkitTransitionDuration="0ms";var _76="translateX("+(_74?"-":"")+window.innerWidth+"px)";var _77="translateX("+(_74?"100%":"-100%")+")";_73.style.webkitTransform=_76;_73.setAttribute("selected","true");_73.style.webkitTransitionDuration="";function startTrans(){_72.style.webkitTransform=_77;_73.style.webkitTransform="translateX(0%)";}_72.addEventListener("webkitTransitionEnd",cb,false);setTimeout(startTrans,0);}function preloadImages(){var _78=document.createElement("div");_78.id="preloader";document.body.appendChild(_78);}function submitForm(_79){if(!iui.busy){iui.busy=true;iui.addClass(_79,"progress");iui.showPageByHref(_79.action,encodeForm(_79),_79.method||"GET",null,clear);}function clear(){iui.removeClass(_79,"progress");}}function encodeForm(_7a){function encode(_7b){for(var i=0;i<_7b.length;++i){if(_7b[i].name){args[_7b[i].name]=_7b[i].value;}}}var _7d={};encode(_7a.getElementsByTagName("input"));encode(_7a.getElementsByTagName("textarea"));encode(_7a.getElementsByTagName("select"));encode(_7a.getElementsByTagName("button"));return _7d;}function findParent(_7e,_7f){while(_7e&&(_7e.nodeType!=1||_7e.localName.toLowerCase()!=_7f)){_7e=_7e.parentNode;}return _7e;}function hasClass(_80,_81){return iui.hasClass(_80,_81);}function replaceElementWithFrag(_82,_83){var _84=_82.parentNode;var _85=_82;while(_84.parentNode!=document.body){_84=_84.parentNode;_85=_85.parentNode;}_84.removeChild(_85);var _86;while(_83.firstChild){_86=_84.appendChild(_83.firstChild);sendEvent("afterinsert",document.body,{insertedNode:_86});}sendEvent("afterinsertend",document.body,{fragment:_83});}function $(id){return document.getElementById(id);}function ddd(){console.log.apply(console,arguments);}})();