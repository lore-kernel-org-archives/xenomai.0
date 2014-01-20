Message-ID: <52DD8F27.1050008@xenomai.org>
Date: Mon, 20 Jan 2014 22:03:35 +0100
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <52BD3D0E.3010802@xenomai.org> <52C6C14C.9000306@web.de>
 <52C6F57B.3090101@xenomai.org> <52C71AE0.3090807@web.de>
 <52C7260C.1010004@xenomai.org> <52C7DAA8.5090506@web.de>
In-Reply-To: <52C7DAA8.5090506@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] reworking rtdm
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Jan Kiszka <jan.kiszka@web.de>
Cc: Xenomai <xenomai@xenomai.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 01/04/2014 10:55 AM, Jan Kiszka wrote:
> On 2014-01-03 22:05, Gilles Chanteperdrix wrote:
>>>> Now the question is, do we want to have a macro allowing to fix the
>>>> callbacks signature to compile for both 2.x and forge? Or do you plan to
>>>> stop supporting 2.x for instance for rtnet, when 3.0 is out?
>>>>
>>
>>> I guess RTnet will not be the only affected project.
>>
>> I understand you want to be able to support both API I take it?
> 
> Yes, we have to for a certain period. X3-only drivers may just use the
> new API, but those supporting X2 for longer while will require wrappers.
> Those should ideally be placed in some rtdm/compat.h which could then be
> carried by out-of-tree drivers in case the target Xenomai version does
> not provide it.

So, coming back from that discussion, I propose:

#if FORGE
#define RTDM_CONTEXT(name) rtdm_dev_context_t *name
#define RTDM_DEFINE_USER_INFO(name, context) rtdm_user_info_t *name = rtdm_user_info(context)
#else /* CLASSIC */
#define RTDM_CONTEXT(name) rtdm_dev_context_t *name, rtdm_user_info_t __user_info __attribute__((unused))
#define RTDM_DEFINE_USER_INFO(name, context) rtdm_user_info_t *name = __user_info
#endif

So, a callback would be written

ssize_t foo_read(RTDM_CONTEXT(fd), char *__user buf, size_t size)
{
	...
}

And if it needs the user_info, it would be:

ssize_t foo_read(RTDM_CONTEXT(fd), char *__user buf, size_t size)
{
	RTDM_DEFINE_USER_INFO(user_info, fd);
	... user user_info
}


- -- 
                                                                Gilles.
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with Icedove - http://www.enigmail.net/

iD8DBQFS3Y8nGpcgE6m/fboRAhkwAJ0Wk294Xvky01ZgWSHE6zd1IQ2qhgCeJzWa
3a1ttHg31MfUvvGHILjoAqQ=
=zrcC
-----END PGP SIGNATURE-----

