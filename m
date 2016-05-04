From: Umair Ali <ali.umair@tut.fi>
Date: Wed, 4 May 2016 13:03:35 +0000
Message-ID: <2396B4D2166B62479FBBE370D4A7C1F30A733197@mb2010-3.intra.tut.fi>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Xenomai] mmap a file in rtdm moudle without switching the mode
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "xenomai@xenomai.org" <xenomai@xenomai.org>

Hello ,

My aim is to open and read a file in the rtdm module. This file will be acc=
essed or red  periodically using the kernel timers until the whole file is =
read completely. What I am doing is as follows
- Open the file and mapped the file using mmap() in the user space in real =
time.
-  a kernel module is running in the back ground with timer initialized
-  run the application in user space and pass the mmap pointer along with t=
he size of file to the kernel module by using the read() function to read t=
he device.
- In the read_rt thread of module the pointer of the mapped file is assigne=
d to the global  char pointer and timer is started.
- The timed function is using the global char pointer to access file but fa=
ils when the read_rt ends
- Meanwhile the user space app is also ended after passing the pointer and =
file size.

The above technique is not working because when the read_rt ends then the k=
ernel is stuck. I have read on the net that I should pass the pointer of mm=
aped file from userspace to the kernel space as mmap is ponting the file to=
 kernel memory. It seems to me that memory is erased once the user space ap=
p or read_rt in module ends. Please guide me if I am on the right path or w=
hat should I do so that I can read the file in the module and read periodic=
ally using kernel timer. Is there any rtdm functions which I have missed an=
d can help me.=20

Thanks in advance

Regards
ali

