Message-ID: <ff1d78710611110157v20f11fd5ibb35b60502a6dbdb@domain.hid>
Date: Sat, 11 Nov 2006 10:57:22 +0100
From: "Steven Kauffmann" <steven.kauffmann@domain.hid>
MIME-Version: 1.0
Content-Type: multipart/alternative; 
	boundary="----=_Part_38501_25349255.1163239042648"
Subject: [Xenomai-help] Sudo not found when running the latency test
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

------=_Part_38501_25349255.1163239042648
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

We're using an embedded system, the Virtex2pro from Xilinx (XC2VP300). This
chipset includes 2 powerpc's (ppc-405) and a FPGA. We're running a linux
kernel from denx (20060707) patched with 'adeos-ipipe-2.4.25-ppc-CVS-
20060707-1.1-04.patch '. We got the linux kernel from denx with cvs:
        cvs -d :pserver:anonymous@domain.hid login
        cvs -z6 -d :pserver:anonymous@domain.hid co -P -D 20060707
linuxppc_2_4_devel
We got xenomai with svn:
        svn co svn://svn.gna.org/svn/xenomai/branches/v2.2.x
xenomai_branches

With the Xilinx software (EDK 8.1) we built board support packages for the
kernel.  We use the crosstool from
<http://kegel.com/crosstool/#download> to build the ppc crosscompiler.


We build the rootfilesystem with the busybox_1_1_stable release. We got the
following error when running the latency test: "./run".

*
*
* Type ^C to stop this application.
*
*
/usr/xenomai/bin/xeno-load: /usr/xenomai/bin/xeno-load: 249: sudo: not found

If we run "./latency", no error occurs.

Did we forget something obvious?  What would be the best way to debug this
situation?  Any hints are welcome!

Best regards,

Stefan De la haye & Steven Kauffmann

------=_Part_38501_25349255.1163239042648
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>We're using an embedded system, the Virtex2pro from Xilinx
(XC2VP300). This chipset includes 2 powerpc's (ppc-405) and a FPGA.
We're running a linux<br>kernel from denx (20060707) patched with 'adeos-ipipe-2.4.25-ppc-CVS<div id="mb_0">-20060707-1.1-04.patch
'. We got the linux kernel from denx with cvs: <br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cvs -d :pserver:anonymous@domain.hid login<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; cvs -z6 -d :pserver:anonymous@domain.hid co -P -D 20060707 linuxppc_2_4_devel<br>We got xenomai with svn:
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; svn co svn://svn.gna.org/svn/xenomai/branches/v2.2.x xenomai_branches<br><br>With the Xilinx software (EDK 8.1) we built board support packages for the kernel.&nbsp; We use the crosstool from <br>&lt;<a href="http://kegel.com/crosstool/#download" target="_blank" onclick="return top.js.OpenExtLink(window,event,this)">
http://kegel.com/crosstool/#download</a>&gt; to build the ppc crosscompiler.<br><br><br>We
build the rootfilesystem with the busybox_1_1_stable release. We got
the following error when running the latency test: &quot;./run&quot;.
<br><br>*<br>*<br>* Type ^C to stop this application.<br>*<br>*<br>/usr/xenomai/bin/xeno-load: /usr/xenomai/bin/xeno-load: 249: sudo: not found<br><br>If we run &quot;./latency&quot;, no error occurs. <br><br>Did we forget something obvious?&nbsp; What would be the best way to debug this
<br>situation?&nbsp; Any hints are welcome!<br><br>Best regards,<br><br>Stefan De la haye &amp; Steven Kauffmann</div>

------=_Part_38501_25349255.1163239042648--

