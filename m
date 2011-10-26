Message-ID: <4EA7F599.4000304@domain.hid>
Date: Wed, 26 Oct 2011 13:57:13 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>	<68d35b0c2502bcfcd82a.1318861191@domain.hid>	<4EA7DF14.6050307@domain.hid>
	<CAAXf6LWUBDNYe48Xk76yApTeJzf9bW0o8Y8reYur65dKMbH_Uw@domain.hid>
In-Reply-To: <CAAXf6LWUBDNYe48Xk76yApTeJzf9bW0o8Y8reYur65dKMbH_Uw@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] [PATCH 2 of 4] psos: port long_names feature to
 xenomai-forge
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/options/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Thomas De Schampheleire <patrickdepinguin+xenomai@domain.hid>
Cc: xenomai@xenomai.org

On 10/26/2011 12:41 PM, Thomas De Schampheleire wrote:
> On Wed, Oct 26, 2011 at 12:21 PM, Philippe Gerum<rpm@xenomai.org>  wrote:
>> On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
>>>
>>> While psos interface accepts 4 character ids, non null terminated,
>>> xenomai uses longer ids which must be null terminated. Revert to
>>> the behaviour of psos interface, while allowing long id strings if
>>> the global variable psos_long_names is set to non-zero.
>>>
>>> This patch ports the original fix from xenomai to xenomai-forge,
>>> fixing following problems:
>>> * a bug in __psos_maybe_short_name so that only 3 characters are
>>>    retained
>>> * the call to __psos_maybe_short_name also needs to be done in the
>>>    ident functions
>>> * the pt_create and pt_ident functions also need to be adapted
>>>
>>
>> Please merge long_names.h into psos.h, having a separate header for this is
>> way overkill and brings nothing.
>
> It avoids exposing an internal interface to applications through psos.h.
> If anything, I think we should make a psos_internal.h or whatever,
> that can host __psos_maybe_short_name among others.

Yes, that would be better. include/psos is really for external stuff 
anyway. lib/psos/internal.h would make sense.

>
> ~Thomas
>


-- 
Philippe.

