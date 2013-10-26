Message-ID: <526BE0E3.80309@xenomai.org>
Date: Sat, 26 Oct 2013 17:33:55 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <525C3B94.1060200@grandegger.com> <525C43BC.1000103@siemens.com>
 <525C4CE1.8040902@grandegger.com>
In-Reply-To: <525C4CE1.8040902@grandegger.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] [PATCH] rtcan: add missing license terms
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfgang Grandegger <wg@grandegger.com>
Cc: Jan Kiszka <jan.kiszka@siemens.com>, "Xenomai@xenomai.org" <Xenomai@xenomai.org>

On 10/14/2013 09:58 PM, Wolfgang Grandegger wrote:
> On 10/14/2013 09:19 PM, Jan Kiszka wrote:
>> On 2013-10-14 20:44, Wolfgang Grandegger wrote:
>>> ---
>>>  src/utils/can/rtcanrecv.c |   19 +++++++++++++++++++
>>>  src/utils/can/rtcansend.c |   19 +++++++++++++++++++
>>>  2 files changed, 38 insertions(+)
>>>
>>> diff --git a/src/utils/can/rtcanrecv.c b/src/utils/can/rtcanrecv.c
>>> index f3178c5..644de55 100644
>>> --- a/src/utils/can/rtcanrecv.c
>>> +++ b/src/utils/can/rtcanrecv.c
>>> @@ -1,3 +1,22 @@
>>> +/*
>>> + * Program to receive CAN messages
>>> + *
>>> + * Copyright (C) 2006 Wolfgang Grandegger <wg@grandegger.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>> + */
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <signal.h>
>>> diff --git a/src/utils/can/rtcansend.c b/src/utils/can/rtcansend.c
>>> index d178305..dd6ee30 100644
>>> --- a/src/utils/can/rtcansend.c
>>> +++ b/src/utils/can/rtcansend.c
>>> @@ -1,3 +1,22 @@
>>> +/*
>>> + * Program to send CAN messages
>>> + *
>>> + * Copyright (C) 2006 Wolfgang Grandegger <wg@grandegger.com>
>>> + *
>>> + * This program is free software; you can redistribute it and/or modify
>>> + * it under the terms of the GNU General Public License as published by
>>> + * the Free Software Foundation; either version 2 of the License, or
>>> + * (at your option) any later version.
>>> + *
>>> + * This program is distributed in the hope that it will be useful,
>>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> + * GNU General Public License for more details.
>>> + *
>>> + * You should have received a copy of the GNU General Public License
>>> + * along with this program; if not, write to the Free Software
>>> + * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
>>> + */
>>>  #include <stdio.h>
>>>  #include <stdlib.h>
>>>  #include <signal.h>
>>>
>>
>> Signed-off-by: Jan Kiszka <jan.kiszka@siemens.com>
> 
> Feel free to add my "Signed-off-by".  I did a "git log" on xenomai-2.6
> and realized only a few of them.

Done, thanks.


-- 
                                                                Gilles.

