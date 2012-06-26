From: "George Pontis" <GPontis@z9.com>
Date: Tue, 26 Jun 2012 06:23:45 -0700
Message-ID: <009c01cd539e$e9f81420$bde83c60$@com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Language: en-us
Subject: [Xenomai] ARM, exception #0 ?
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Running Xenomai 2.6.0 on an ARM at91sam9g45. I recently updated from Adeos
patch adeos-ipipe-3.0.13-arm-1.18-05 to adeos-ipipe-3.0.13-arm-1.18-09. Then
built a new kernel and gave it to the application developers for a test.
There were other changes in the root FS and a few tweaks in the kernel, but
none that looked (to me) like they would affect Xenomai. They report this
new error:

> Xenomai: Switching ADC Task to secondary mode after exception #0 from 
> user-space at 0xffff0fbc (pid 723)

And then nothing about the app works any more. What does this mean ?

George



