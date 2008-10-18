Message-ID: <48FA1849.5090200@domain.hid>
Date: Sat, 18 Oct 2008 19:09:29 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <48F9F12F.7090708@domain.hid> <48F9F438.7010209@domain.hid>
In-Reply-To: <48F9F438.7010209@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-core] [PATCH 1/1] Use SIGWINCH to trigger priority
 change in user-space.
Reply-To: rpm@xenomai.org
List-Id: "Xenomai life and development \(bug reports, patches,
	discussions\)" <xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
List-Archive: </public/xenomai-core>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-core-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-core>,
	<mailto:xenomai-core-request@domain.hid>
To: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
Cc: Xenomai core <Xenomai-core@domain.hid>

Gilles Chanteperdrix wrote:
> Gilles Chanteperdrix wrote:
>> Hi,
>>
>> here is a patch which implements the idea discussed previously of 
>> re-using SIGWINCH to trigger priority changes in user-space. There is 
>> only one patch, but the files should have been put in a logical order
>> to make review easier.
> 
> Since there are chances of conflicts with Jan patches series, I will
> rebase this patch after Jan patches have been commited.
> 

I'm reviewing those now, this should not be long.

-- 
Philippe.

