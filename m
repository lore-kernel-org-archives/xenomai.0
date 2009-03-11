Message-Id: <2977BC40-6544-4C40-8047-B5A1977C1AE3@domain.hid>
From: Steven Seeger <steven.seeger@domain.hid>
In-Reply-To: <49B7F6A6.5060603@domain.hid>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v930.3)
Date: Wed, 11 Mar 2009 13:38:54 -0400
References: <67b6b3430903091727o4a60a28ay91c7ba35ad7d08ef@domain.hid>	
	<49B634F1.2040101@domain.hid>	
	<D8EB3A02-F76F-442A-8B0D-7F26D4E16D16@domain.hid>	
	<49B6C5E5.3090302@domain.hid>	
	<67b6b3430903101403r183d6d4cwe100619a293abae2@domain.hid>	
	<49B6D69E.8050707@domain.hid>	
	<67b6b3430903101516n354263d6of00c79e130118e1@domain.hid>	
	<49B6E8B1.2030900@domain.hid>	
	<67b6b3430903101552u37244233s587898c4d0f9ef3d@domain.hid>	
	<49B78113.3030308@domain.hid>
	<67b6b3430903110951m71679f89ud83859654f04aabb@domain.hid>
	<49B7EF28.4080203@domain.hid>
	<C0049A04-822D-497A-BBA0-E5C8F6E8A947@domain.hid>
	<49B7F1AC.9000301@domain.hid>
	<494CC2B0-5509-46F5-B480-CA34038F0226@domain.hid>
	<49B7F6A6.5060603@domain.hid>
Subject: Re: [Xenomai-help] rt_queue_write return 1, with no receiver
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: rpm@xenomai.org
Cc: xenomai-help <xenomai@xenomai.org>

> You are sharing buffers with kernel space using RT_QUEUEs. If  
> anything goes wrong writing to this address space, you may well end  
> up corrupting some kernel data, including some internal Xenomai data  
> structures. The fact that looking at /proc/xenomai crashes the  
> system is telling, since the backing code may attempt to scan such  
> data structures.
>
> Since you also have your own driver running, this might be another  
> source for the issue. Non-reg tests did not reveal any issue with  
> RT_QUEUEs so far.

Actually we have disabled the driver and do not even load it until the  
FPU issue is resolved.

Mark is taking Jan's advice and disabling klogd now.

Steven


