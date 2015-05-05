MIME-Version: 1.0
Date: Tue, 5 May 2015 19:05:42 +0200
Message-ID: <CAL5YyVaSAnPWbtMTnSvJUBOFncN+KqU-Wkm2uS9dCo+j9q0iyQ@mail.gmail.com>
From: ACO31 <alain.cordat@gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: [Xenomai] X86 rebbot when i use latency
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hi,
I've made the same thing with Raspberry, xenomai + minimal rootfs -> all is
Ok
On the "X86" board with rs232:
When I run xenomai kernel, no error occurs on dmesg, and idem on deported
terminal (it seem me). But when I run " latency", the host freezes
completely and no new message occurs in terminal.
I don't use netconsole because I have the probleme with SMI. but the kernel
command line is the same as the previous mail
thanks
alain
