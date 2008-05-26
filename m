Message-ID: <2ff1a98a0805261021s1d369a23ic63451e9b87b68b6@domain.hid>
Date: Mon, 26 May 2008 19:21:02 +0200
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <d6c8ef150805261016q7250012cxcb0f15aa8ae817fd@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <d6c8ef150805231056n3a9ea030jada65bd5a7c2a2c0@domain.hid>
	<18489.30774.304777.148110@domain.hid>
	<d6c8ef150805260626o3ba03d42sce1100bab89540a5@domain.hid>
	<d6c8ef150805260929yeb4e263o618c446cdd96856b@domain.hid>
	<2ff1a98a0805260947q4587700era0e5af4527a26cfc@domain.hid>
	<2ff1a98a0805260959wded8f38tf266d11a921f9c04@domain.hid>
	<d6c8ef150805261004l58f0c832n735e68dd91eb1123@domain.hid>
	<2ff1a98a0805261014o5900fc40i61332fdb19a8ea08@domain.hid>
	<d6c8ef150805261016q7250012cxcb0f15aa8ae817fd@domain.hid>
Subject: Re: [Xenomai-help] Interrupt priorities and handling problems
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: Bosko Radivojevic <bosko.radivojevic@domain.hid>
Cc: xenomai-help <xenomai@xenomai.org>

On Mon, May 26, 2008 at 7:16 PM, Bosko Radivojevic
<bosko.radivojevic@domain.hid> wrote:
> On Mon, May 26, 2008 at 7:14 PM, Gilles Chanteperdrix
> <gilles.chanteperdrix@xenomai.org> wrote:
>
>> To know this we need to compare a trace taken at maximum time, with
>> and without ethernet.
>
> OK. I'll remove freeze call, and capture max with and without eth.

No, you need to call freeze when maximum is reached, which means you
need to add some measurement instrumentations, based on rt_timer_tsc,
detect the maximum and call freeze in this case.

-- 
 Gilles

