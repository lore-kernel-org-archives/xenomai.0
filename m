From: Niklaus Giger <niklaus.giger@domain.hid>
Subject: Re: [Xenomai-core] Some new test cases for the vxWorks skin
Date: Wed, 14 Jun 2006 18:50:10 +0200
References: <200606122058.18019.niklaus.giger@domain.hid>
	<17552.3527.468486.973862@domain.hid>
In-Reply-To: <17552.3527.468486.973862@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606141850.11764.niklaus.giger@domain.hid>
Reply-To: niklaus.giger@domain.hid
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
Cc: xenomai-core <xenomai@xenomai.org>

Am Mittwoch, 14. Juni 2006 15:23 schrieb Gilles Chanteperdrix:
> Niklaus Giger wrote:
>  > Is it okay to submit such a patch, which mixes a  different test cases
>  > or shall I submit the patches in smaller pieces? Should the test that I
>  > put into the procedure msgDuringInt better be inlined? Or should I add a
>  > new file for these tests?
>
> I think it is a good idea to add some more tests to the message queues
> tests. I also agree with the idea of documenting the differences instead
> of being bug compatible. However, I would apply a few cosmetic changes
> to the patch before including it. Comments follow, please tell me if you
> agree with these changes.
>
>  > -    TEST_ASSERT(taskIdVerify(0) == ERROR && errno ==
>  > S_objLib_OBJ_ID_ERROR); +    errno = 0;
>  > +    TEST_ASSERT(taskIdVerify(0) == ERROR && errno == 0);
>
> This is weird, it means that taskIdVerify does not set errno when passed
> a null argument, but returns ERROR. Anyway, and this goes for all other
> checks, I do not like errno = 0. If errno is not set, let us not check
> it.
Okay. That's probably safer.
>
>  > +    errno = 0;
>  > +    TEST_ASSERT(taskIdVerify(malloc(20)) == ERROR && errno ==
>  > S_objLib_OBJ_ID_ERROR);
>
> You should memset the new malloced block (or use calloc instead of
> malloc), in order to be sure that it is invalid. And free it after use.
I didn't bother about the memory leak, as the testsuite was not meant to live 
a long time. And it kept the changes smaller. But I would never accept this 
kind of code in a production system. So we better clean it up.
>  > +    TEST_ASSERT_OK(rc);
>  > +    TEST_ASSERT(errno == 0);
>
> There is no guarantee that the syscalls will not set errno when
> returning OK. I would remove every TEST_ASSERT(errno == 0).
Agreed.
>  > +    TEST_ASSERT(rc == ERROR);
>  > +    TEST_ASSERT(errno == S_msgQLib_NON_ZERO_TIMEOUT_AT_INT_LEVEL);
>
> Here, and in several other places, I would use only one assert, as it is
> done in other tests.
Fine for me. Just while developing test cases it was more convenient to know 
exactly which condition lead to an error. 
>  > +    errno = 0;
>  >      qid = msgQCreate(NMESSAGES,sizeof(int),0xffff);
>  > -    TEST_ASSERT(qid == 0 && errno == S_msgQLib_INVALID_QUEUE_TYPE);
>  > +    TEST_ASSERT(qid != 0 && errno == 0);
>  > +    if (qid) msgQDelete(qid);
>
> Here, it appears that vxworks and xenomai vxworks skin are incompatible,
> changing the test code will make the test fail for xenomai. Would not it
> be a better idea to document this difference ? After all, users code is
> supposed to never use erroneous arguments, and if it does, it is better
> to learn it when porting code to xenomai than to keep ignoring it
> silently.
Agreed. Do you agree with the following sentence for vxworks-skin.txt?

Passing a argument to options with non defined bits for msgQCreate will return 
0 under the xenomai skin. VxWorks returns a valid msqId.

>  > -    rc = msgQSend(qid,(char
>  > *)&message_list[0],0,WAIT_FOREVER,MSG_PRI_NORMAL); +    errno = 0;
>  > +    rc = msgQSend(qid,(char *)&message_list[0],2*message_list[0],
>  > WAIT_FOREVER,MSG_PRI_NORMAL);
>  >
>  >      TEST_ASSERT(rc == ERROR && errno == S_msgQLib_INVALID_MSG_LENGTH);
>
> Accepting null length messages may be a feature, does a receiver receive
> the null length message with vxworks ?
I will check and give you an answer about this later (probably before Friday 
evening).

>  > -    rc = msgQReceive(qid,(char *)&msg,0,NO_WAIT);
>  > -    TEST_ASSERT(rc == ERROR && errno == S_msgQLib_INVALID_MSG_LENGTH);
>
> Null length message again, does this work with the real vxworks ?
Same here.
>  > +    rc = msgQNumMsgs(qid);
>
> You do not use this value. Missing TEST_ASSERT ?
No. Bad cleanup before sending. I had some redundant tests after this 
position. Just kill this line.

You may either check in a modified version of this patch or wait till I send 
you one which incorporates your suggestions.

Best regards

-- 
Niklaus Giger

