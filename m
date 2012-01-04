Message-ID: <4F045745.9010404@domain.hid>
Date: Wed, 04 Jan 2012 14:42:29 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CA+fRa6dugu69gLWA4fRTZbbiXr2gyCN8SKb2fQaJhOx8AG+B7w@domain.hid>
	<CAAXf6LXPrkrbdnOx88q=4Jo3eDu9zPW1yEdt3cyt5nC_YMq9Qg@domain.hid>
In-Reply-To: <CAAXf6LXPrkrbdnOx88q=4Jo3eDu9zPW1yEdt3cyt5nC_YMq9Qg@domain.hid>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai-help] compilation problems
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
Cc: xenomai@xenomai.org, daniele.gottfried@domain.hid

On 01/04/2012 02:18 PM, Thomas De Schampheleire wrote:
> On Wed, Jan 4, 2012 at 1:22 PM, Daniele <danielegottfried@domain.hid> wrote:
>> I'm trying to compile an example of Xenomai, but gives me this error:
>>
>> /usr/bin/ld : cannot find -lrtdk
> 
> You will have to provide more information than this.
> The error is clear: it cannot find librtdk.so.
> 
> Did you already compile the Xenomai userspace libraries? You can't
> compile an example without doing that.

rtdk disappeared from xenomai 2.6.0 (it is merged in libxenomai). 
The fix for the examples will be in xenomai 2.6.1. 
You can apply this patch:
http://git.xenomai.org/?p=xenomai-2.6.git;a=commit;h=87ac1c1f32181b5bcf4961aea30b9df34ba8a7ce

-- 
					    Gilles.

