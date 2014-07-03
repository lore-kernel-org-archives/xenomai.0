Message-ID: <53B512BB.9040908@ma-info.de>
Date: Thu, 03 Jul 2014 10:22:19 +0200
From: Frede Florian <florian.frede@ma-info.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Xenomai on PhyCore/Board
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Hello,

We started a new real time project. For this project we decided to 
compare the PREEMPT_RT and Xenomai on our future hardware. For this we 
got two developer board from Phytec.

  * Linux-phyCORE-AM335x-Kit
    (https://www.osadl.org/Profile-of-system-in-rack-7-slot-5.qa-profile-r7s5.0.html)
  * phyBOARD-Wega-AM335x
    (https://www.osadl.org/Profile-of-system-in-rack-8-slot-8.qa-profile-r8s8.0.html)

Now I have the Problem that I can not compile a running Linux with 
Xenomai on this board. The supplier delivers patches for Kernel 3.2 for 
the board  and on the linked page I get patches for the Kernel 3.12.19.

  * Is there a possibility to run Xenomai on one on this kernel versions?
  * I am really no expert in writing patches for a Kernel so I need some
    help or a HowTo. Where can I find that help?

Thanks for helping a Xenomai beginner.

Florian
