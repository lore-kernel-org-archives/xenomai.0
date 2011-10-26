Message-ID: <4EA7DF14.6050307@domain.hid>
Date: Wed, 26 Oct 2011 12:21:08 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <patchbomb.1318861189@domain.hid>
	<68d35b0c2502bcfcd82a.1318861191@domain.hid>
In-Reply-To: <68d35b0c2502bcfcd82a.1318861191@domain.hid>
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

On 10/19/2011 09:35 AM, Thomas De Schampheleire wrote:
> While psos interface accepts 4 character ids, non null terminated,
> xenomai uses longer ids which must be null terminated. Revert to
> the behaviour of psos interface, while allowing long id strings if
> the global variable psos_long_names is set to non-zero.
>
> This patch ports the original fix from xenomai to xenomai-forge,
> fixing following problems:
> * a bug in __psos_maybe_short_name so that only 3 characters are
>    retained
> * the call to __psos_maybe_short_name also needs to be done in the
>    ident functions
> * the pt_create and pt_ident functions also need to be adapted
>

Please merge long_names.h into psos.h, having a separate header for this 
is way overkill and brings nothing.

-- 
Philippe.

