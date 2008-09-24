Message-ID: <48DA015F.4090508@domain.hid>
Date: Wed, 24 Sep 2008 10:59:11 +0200
From: Mathieu Maret <mathieu.maret@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai-help] Error with Xenosim
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: xenomai@xenomai.org

Hello everybody!
I install Xenosim 2.4.5 with Xenomai 2.4.3 with the Linux Kernel 2.6.23. 
(Debian 4.0)
I can run Xenosim but when i try to create a new project, I get an Error.

Here is the log of the Error :

unknown option "-image"
unknown option "-image"
    while executing
"$data(w:hlist) add $vpath -text $text -data $curpath -image $img"
    (procedure "tixDirList:ListHierachy" line 10)
    invoked from within
"tixDirList:ListHierachy $w $npath $vpath"
    (procedure "tixDirList:LoadDir" line 13)
    invoked from within
"tixDirList:LoadDir $w $npath $vpath"
    (procedure "tixDirList:SetValue" line 5)
    invoked from within
"tixDirList:SetValue $w $npath [tixFSInternal $npath]"
    (procedure "tixDirList:chdir" line 5)
    invoked from within
"tixDirList:chdir $w $value"
    (procedure "tixDirList:config-value" line 4)
    invoked from within
"tixDirList:config-value 
.tixapp_filedialog_tixExFileSelectDialog.fsbox.lf.pane.1.dirlist 
/home/mmaret"
    invoked from within
"tixDirList  $dpane.dirlist  -command   [list 
tixExFileSelectBox:Cmd-DirList $w] -browsecmd [list 
tixExFileSelectBox:Browse-DirList $w]"
    (procedure "tixExFileSelectBox:ConstructWidget" line 32)
    invoked from within
"tixExFileSelectBox:ConstructWidget 
.tixapp_filedialog_tixExFileSelectDialog.fsbox"
    invoked from within
"tixExFileSelectBox $w.fsbox -dialog $w  -command $data(-command)"
    (procedure "tixExFileSelectDialog:ConstructWidget" line 5)
    invoked from within
"tixExFileSelectDialog:ConstructWidget 
.tixapp_filedialog_tixExFileSelectDialog"
    invoked from within
"$type .tixapp_filedialog_$type"
    (procedure "tixAppContext:filedialog" line 12)
    invoked from within
"tixAppContext:filedialog tix tixExFileSelectDialog"
    invoked from within
"tix filedialog tixExFileSelectDialog"
    (procedure "Workspace:newProject" line 44)
    invoked from within
"Workspace:newProject .c0x81176d0"
    invoked from within
".c0x81176d0.mbar.project.m invoke active"
    ("uplevel" body line 1)
    invoked from within
"uplevel #0 [list $w invoke active]"
    (procedure "tk::MenuInvoke" line 50)
    invoked from within
"tk::MenuInvoke .c0x81176d0.mbar.project.m 1"
    (command bound to event)



Tcl/Tk and Tix 8.4 are installed
(with corresponding -dev package)

Any Idea about the error?
(I can bypass the error by specifying the bin as an argument to xenosim 
or by modifying the .mvmrc file but it's still better with a graphic 
interface :) )

Any Idea about the Error?
Thanks a lot!

