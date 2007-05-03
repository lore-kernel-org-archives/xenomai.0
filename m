Date: Thu, 3 May 2007 08:57:54 +0100 (BST)
From: somshekar kadam <som_kadam@domain.hid>
In-Reply-To: <461F1A14.9090609@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Message-ID: <164351.60035.qm@domain.hid>
Subject: [Xenomai-core] Xenomai module poblem
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: xenomai@xenomai.org

Hi All, 

  I have already posted to the maling list regarding
the Xenomai and ADEOS release for MIPS. Now we are in
a stage where all User RT Applications are working
fine. 
Unless we give complete port to the customer we wont
be able to release to open source the work done. I
know this is not liked by anyone, our team needs to
leave with it. 
 May 12 is the date to where we think of giving the
final release. 
now we are left with only one problem the xenomai
module doesnt work for us, it fails in start_thread
for module. same context switch will be used for
xenomai module also, right now no idea on this may be
some pointer will help us speedup the release and
contribute to opensource. we have done latency test we
are getting 19Us for interrupt latency 33 us for
context switch latency and normal latekcy is 77us. 
I came across Dmitry Adamushko doing the same work,
may if any pointers you have will help us. 

Thanks In advance 
Neelu



      Send a FREE SMS to your friend's mobile from Yahoo! Messenger. Get it now at http://in.messenger.yahoo.com/

