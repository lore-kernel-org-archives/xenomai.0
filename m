From: Jean-Marc Lenoir <jean-marc.lenoir@univ-grenoble-alpes.fr>
Message-ID: <57898ff1-afda-849d-dbd6-be3a480d44a8@univ-grenoble-alpes.fr>
Date: Tue, 17 Apr 2018 16:59:01 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: [Xenomai] Questions about IRQ
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

I would like to make a program which handle the interrupt requests of a 
PCI board with Xenomai 3. I'm trying to use this Xenomai API: 
https://xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__core__irq.html 
but there are some points that are not clear at all for me.

1) There is already a Linux driver that handle the IRQ of this board and 
I need to keep this driver running because I use it for the board 
configuration. So, if both a Linux driver and a Xenomai program try to 
handle the same IRQ, what happen? Does Xenomai always have the priority? 
Or do I need to configure something to give the priority to Xenomai?

2) This API works on kernel mode or user mode? (Actually, I'm not sure 
there is a kernel mode, I'm a beginner with Xenomai.)

3) When I'm trying to make a simple program with this API (in user 
mode), I am unable to compile it: there is some missing definitions like 
the structure xnintr. I think I need to change something when I build 
the Xenomai libraries but I don't know what (the current libraries are 
compiled with the options "./configure --with-core=cobalt --enable-smp 
--enable-pshared"). Any idea?

4) If someone know where I can find an example of program using this 
API, it could help me a lot.

Thanks for your help,
Jean-Marc


