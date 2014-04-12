Message-Id: <4C65087F-A489-460C-89B6-660C6F62316E@gmail.com>
From: Andreas Glatz <andi.glatz@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date: Sat, 12 Apr 2014 15:30:40 +0100
Subject: [Xenomai] Analogy: Basic question regarding a4l_snd_insnlist()
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

I think a4l_snd_insnlist() would be the best option for my use-case,  
where I basically want to turn GPIOs on and off, occasionally change  
DAC values and at the end acquire a certain amount of ADC samples. So  
basically it's a linear sequence of synchronous (well, partly  
asynchronous - depending how the last instruction is realized in  
hardware) commands which should get executed at certain points in  
time. However, when I look at a4l_snd_insnlist() I can pass a list of  
instructions but there is no possibility to tell that function when to  
exactly execute each instruction of the list. I think this would be a  
very nice feature to have since you can get pretty good timing  
accuracy with Xenomai as demonstrated previously [1].

IMHO this shouldn't require many changes (at least for synchronous  
instructions): Firstly the a4l_instruction_list struct could be  
generalised so that each instruction gets a relative (?) time when it  
should be executed. This time is then used in a4l_ioctl_insnlist() to  
translate the relative into an absolute time (?) and execute all  
instructions at the given time with the method used in e.g. [1]. If  
the relative time of each instruction is 0, then the modified  
a4l_ioctl_insnlist() falls back to the current mode of operation...  
and it remains compatible with everything before that change.

A.

PS: I think that's a very general use-case since it is required in  
every sequence based hardware control applications (MRI scanners come  
to my mind).

[1] http://www.xenomai.org/pipermail/xenomai/2014-March/030482.html

