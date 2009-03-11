Message-ID: <49B7F1AC.9000301@domain.hid>
Date: Wed, 11 Mar 2009 18:15:24 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
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
In-Reply-To: <C0049A04-822D-497A-BBA0-E5C8F6E8A947@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] rt_queue_write return 1, with no receiver
Reply-To: rpm@xenomai.org
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Steven Seeger <steven.seeger@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

Steven Seeger wrote:
>> Not if the kernel is terminally broken due to this bug. Wild guess: I 
>> would
>> suggest to check how message queue buffers are used by your application,
>> particularly to detect out-of-bound writes.
> 
> This particular queue is always writing a structure of a constant size. 
> So our reads and writes are always constant size. If reading does not 
> return a size that we expect then we assert.
>

Then I have no clue; you may want to try simplifying your test until the bug 
disappears.

> Steven
> 
> 


-- 
Philippe.

