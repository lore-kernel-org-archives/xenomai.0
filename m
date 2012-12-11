MIME-Version: 1.0
In-Reply-To: <CAPpP=rPG6VBxi3TF9Lja7T2LGjMSSTSGcvbR7xTYdPi9omwDRw@mail.gmail.com>
References: <CAPpP=rOpsiFBEZLFUrc_Sjf88J66Q0zDgmrNkaQ5O4xoz=iwYQ@mail.gmail.com>
	<50C74977.4040207@xenomai.org>
	<CAPpP=rOkGfB0Wixi4JcLbPAxKayptTJnGeJO4R_FFGtXJAXx8w@mail.gmail.com>
	<CAPpP=rPG6VBxi3TF9Lja7T2LGjMSSTSGcvbR7xTYdPi9omwDRw@mail.gmail.com>
Date: Tue, 11 Dec 2012 18:15:56 +0100
Message-ID: <CAPpP=rMq-zJXTg5LNFbidx-VA8Fz3_B7itZGt4j0gyOfCq9UwA@mail.gmail.com>
From: alex alex <duch.alexandre@gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Xenomai] RTDM/POSIX - Select mask return value missing in case
 of timeout
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: xenomai@xenomai.org

Here is the patch;

--- syscall1.c    2012-12-11 18:08:31.000000000 +0100
+++ syscall.c    2012-12-11 13:48:24.000000000 +0100
@@ -2498,7 +2498,7 @@
                       &tv, sizeof(tv)))
             return -EFAULT;
     }
-    if (err > 0)
+    if (err >=3D 0)
         for (i =3D 0; i < XNSELECT_MAX_TYPES; i++)
             if (ufd_sets[i]
                 && __xn_copy_to_user((void __user *) ufd_sets[i],

2012/12/11 alex alex <duch.alexandre@gmail.com>

> Tested. It seems to work!
> Thank you.
> I add the patch...
>
>
>
> 2012/12/11 alex alex <duch.alexandre@gmail.com>
>
>> I made the changes and I'm recompiling the kernel, so it takes a little
>> time ...
>> I'll let you know as soon as I know if it works.
>>
>>
>> 2012/12/11 Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
>>
>>> On 12/11/2012 03:07 PM, alex alex wrote:
>>> > Hi,
>>> >
>>> >
>>> > The problem is the following:
>>> >
>>> >
>>> > When the timeout interval expires of the =93select=94 function the re=
turn
>>> value
>>> > of FD_ISSET(fdr,&readfds) is 1 whereas it should be 0.
>>> >
>>> > In ksrc/skins/posix/syscall.c we can see that they are not copy to
>>> > userspace of select return value in case of timeout.
>>> >
>>> >
>>> >
>>> > The attached code shows this bug with the use of a rtdm driver.
>>>
>>> So, could you try making the obvious change in the code? Or do you need
>>> me to send you the patch?
>>>
>>> --
>>>                                             Gilles.
>>>
>>
>>
>
