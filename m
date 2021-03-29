MIME-Version: 1.0
From: ashwin damle <ashwindamle@gmail.com>
Date: Mon, 29 Mar 2021 23:51:38 +0530
Message-ID: <CAC-NLwzFEyQVeHUXHa6jYG9BesxaoA=1c4BHJiBRuKWhSB6Svg@mail.gmail.com>
Subject: How to use RTnet on xenomai3?
Content-Type: text/plain; charset="UTF-8"
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Dear Xenomai support,

I am successfully able to run xenomai3.1 on 4.19.89 on my core-2-duo
machine. Xenomai works nice. Further I want to use RTnet.

From
https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet#installation-folder-overview
I learnt that RTNet is built into Xenomai 3 and so I need not download from
the rtnet page and build it separately. If so then where do I start using
RTNET? Is there any example? The folder mentioned at
https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet_Setup do appear on my
computer.

>From https://source.denx.de/Xenomai/xenomai/-/wikis/RTnet_Setup I
understand that /usr/local/rtnet/ is the directory where the RTNET files
including documentation would be, but this folder is not created on my
system. Therefore, I tried building RTNET from source using the
instructions in the README: I get the error as below

I request your help with an error.
"checking for RT-extension... configure: error: *** RT-extended kernel not
found in /lib/modules/4.19.89_xenomai/build
makefile:51: recipe for target 'config.status' failed
"
I found that many have resolved the problems from by searching for the
error and 5 pages direct to the same solution and that is

 ./configure --with-linux=/path/to/linux-source-with-xenomai-extension
 --with-rtext-config=/path/to/xeno-config

My doubts are

1. Is it necessary to build RTNet from source or is it built in Xenomai 3?
If it is built in then how do I use it. Some steps will be helpful.

2. If the RTNet is to be built from source then how to solve the above
error. I pointed to the Linux source tree I used to build the xenomai
kernel but it throws the same error.

3. What does " /path/to/linux-source-with-xenomai-extension mean the Linux
source folder of Xenomai patched kernel? or does it mean
"/lib/modules/uname-r/build"....None works for me. /path/to/xeno-config
seems to be /usr/xenomai on my machine since xeno-config resides there.

Please help with this. Let me know if you require any more information.

-- 
Ashwin Damle
