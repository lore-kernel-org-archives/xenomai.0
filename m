Message-ID: <bc4264770702241027g1657b785x837ea9038c772293@domain.hid>
Date: Sat, 24 Feb 2007 18:27:41 +0000
From: "roland Tollenaar" <rolandtollenaar@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Subject: [Xenomai-help] thread in thread
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

Hi,

I have a xenomai task running in a Qt application. Its doing its tricks at 1 ms.

I just need brief confirmation of the following:

I have made my own separate thread (QThread) and then started a real
time task within that. I strongly get the feeling that a real-time
task is a thread of its own (I am not so knowledgeable of threads in
plain C ) and I have now ended up starting a thread in a thread?

Is this suspicion correct?

I also still need to discover how to stop a xenomai task from my
application. At the moment I have to kill the entire process with $
kill -9 PID . Any hints would be welcome.

Thanks.

Roland

