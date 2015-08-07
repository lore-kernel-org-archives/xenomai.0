Message-ID: <55C4AA41.1040505@xenomai.org>
Date: Fri, 07 Aug 2015 08:53:21 -0400
From: Jorge Ramirez Ortiz <jro@xenomai.org>
MIME-Version: 1.0
References: <55C17C8E.5000909@gatech.edu> <55C3AEBE.9080603@xenomai.org>
 <55C3C3F8.1090808@gatech.edu> <55C3C7F4.1030107@xenomai.org>
 <12F45B9B-70C3-4278-BA0E-DFC26E19DBF0@gatech.edu>
 <55C495D6.2070706@xenomai.org>
In-Reply-To: <55C495D6.2070706@xenomai.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] analogy calibration issue(s)
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Yogi A. Patel" <yapatel@gatech.edu>
Cc: "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/07/2015 07:26 AM, Jorge Ramirez Ortiz wrote:
>> > # sudo ./../../usr/xenomai/bin/insn_read -c 0 -R 0 -y file
>> > 
>> > Never prints anything, top shows continuous running and increased consumption of memory
> can you send the calibration file please?
> also can you gdb insn_read?
> 
>> > 
>> > Yogi
>> > 
>> > 

also as Gilles suggested, please do upgrade your Xenomai version to rc6 (it is a
trivial action on your side)


-- 
jro

