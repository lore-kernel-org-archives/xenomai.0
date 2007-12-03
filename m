Message-ID: <5a4b7020712030458i7e450b0cq3b1b72d1068f82f9@domain.hid>
Date: Mon, 3 Dec 2007 20:58:53 +0800
From: "jie zhang" <xenomai.rtai@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_4072_8384727.1196686733845"
Subject: [Xenomai-help] mlockall MCL_FUTURE
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

------=_Part_4072_8384727.1196686733845
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi
 I have a question about mlockall, there is a parameter named MCL_FUTURE in
mlockall,  I just want to know in what situation should MCL_FUTURE should be
used, I just know this parameter will lock all the memory this application
used in future, and then it will avoid page-fault, so in this case does the
following two situation are same?

mlockall(MCL_FUTURE| ...
 get resources
 enter rt-context

or?

 get all resources
 mlockall(MCL_CURRENt
 enter rt-context


Thank you!

------=_Part_4072_8384727.1196686733845
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi<br>&nbsp;I have a question about mlockall, there is a parameter named MCL_FUTURE in mlockall,&nbsp; I just want to know in what situation should MCL_FUTURE should be used, I just know this parameter will lock all the memory this application&nbsp; used in future, and then it will avoid page-fault, so in this case does the following two situation are same?
<br><br>mlockall(MCL_FUTURE| ...<br> &nbsp;get resources<br> &nbsp;enter rt-context<br><br>or?<br><br> &nbsp;get all resources<br> &nbsp;mlockall(MCL_CURRENt<br> &nbsp;enter rt-context<br><br><br>Thank you!<br>

------=_Part_4072_8384727.1196686733845--

