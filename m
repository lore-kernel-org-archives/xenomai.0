MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <18381.44749.419005.112838@domain.hid>
Date: Tue, 4 Mar 2008 21:19:25 +0100
In-Reply-To: <47CDA626.4010604@domain.hid>
References: <47CDA626.4010604@domain.hid>
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Subject: Re: [Xenomai-help] How should rt_task_delete(NULL)  be used?
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Anders Blomdell <anders.blomdell@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Anders Blomdell wrote:
 > Why does the following program grow it's VMSIZE? This is the output I get:
 > 
 > [child =  0,  0] VmSize:            1912 kB
 > [child =  1,  1] VmSize:            1980 kB
 > [child =  2,  2] VmSize:            2048 kB
 > [child =  3,  3] VmSize:            2116 kB
 > [child =  4,  4] VmSize:            2184 kB
 > [child =  5,  5] VmSize:            2252 kB
 > [child =  6,  6] VmSize:            2320 kB
 > [child =  7,  7] VmSize:            2388 kB
 > [child =  8,  8] VmSize:            2456 kB
 > [child =  9,  9] VmSize:            2524 kB
 > [child = 10, 10] VmSize:            2592 kB
 > [child = 11, 11] VmSize:            2660 kB
 > [child = 12, 12] VmSize:            2728 kB
 > [child = 13, 13] VmSize:            2796 kB
 > [child = 14, 14] VmSize:            2864 kB
 > [child = 15, 15] VmSize:            2932 kB
 > [child = 16, 16] VmSize:            3000 kB
 > [child = 17, 17] VmSize:            3068 kB
 > [child = 18, 18] VmSize:            3136 kB
 > [child = 19, 19] VmSize:            3204 kB

Could you dump /proc/self/maps at the beginning and the end, to see
where the reserved memory comes from ?

-- 


					    Gilles Chanteperdrix.

