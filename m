Message-ID: <421CBDF3.5040301@domain.hid>
Date: Wed, 23 Feb 2005 18:31:31 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Adeos-main] No Help for Porting?
References: <0D21CBD1298D2C4790E2F2B86D96EC19380256@domain.hid>
In-Reply-To: <0D21CBD1298D2C4790E2F2B86D96EC19380256@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: adeos-main-admin@domain.hid
Errors-To: adeos-main-admin@domain.hid
List-Help: <mailto:adeos-main-request@domain.hid>
List-Post: <mailto:adeos-main@gna.org>
List-Subscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Id: General discussion about Adeos <adeos-main.gna.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/adeos-main>,
	<mailto:adeos-main-request@domain.hid>
List-Archive: <https://mail.gna.org/public/adeos-main/>
To: "Reynolds, Terry (Contractor-SIMTECH)" <terry.reynolds2@domain.hid>
Cc: adeos <adeos-main@gna.org>

Reynolds, Terry (Contractor-SIMTECH) wrote:
> Hello,
>  
> I've posted several questions about porting Adeos, and never received a single reply.  I've noticed other people posting about porting to other CPU's in the last few months, and never seen a reply for them either.  
>  

You did not specify which patch you currently use as a reference, did 
you? Depending on the 2.4/2.6 issue, authors are different.

If talking about the 2.6 one, then regarding the LR stuff, the answer is 
likely there:
adeos/ppc.c: __adeos_init_domain (), have a look at the comment inside.
The problem you encounter is likely due to some lack of initial setup of 
the domain stack.

> Is this group an inappropriate place to post such a request?  
>  

No it isn't. It's just like there are much more lurkers than 
contributors on this list, which tends to confirm the general rule in 
the free software world and elsewhere.

> Did I commit some awful faux pas in asking for help in this way?
>  

AFAIC, you were not specific enough. Additionally, not that many people 
asking for porting information (and there are quite a few, asking often 
privately, believe me) contributed back any patch to the project, so 
sometimes people that do might find this tiresome. Fortunately, there 
have been notable exceptions for the PPC and recently the ARM supports.

> I thought adding new capabilities to Open Source projects was the reason for things being Open.  If everyone is simply too busy to reply to such requests, please kindly post a message asking us all to keep our stupid questions to ourselves!
>  

Believe it or not, and still AFAIC, I'm quite busy indeed, and spending 
the time to read your mail, infere the details of the issue you didn't 
give, look into the relevant code written months ago, and craft some 
useful answer about it is likely going to be lacking for some other 
business at the end of the day, especially if I don't see any code 
floating around.

> Sorry for taking up your time.
>  

Don't be. Nobody forces us to give it, but conversely, I don't feel 
owing you any answer, even if your question is smart.

>  
> Terry.
> 
> _______________________________________________
> Adeos-main mailing list
> Adeos-main@domain.hid
> https://mail.gna.org/listinfo/adeos-main


-- 

Philippe.

