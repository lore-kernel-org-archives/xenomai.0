Message-ID: <441AE2D7.2070605@domain.hid>
Date: Fri, 17 Mar 2006 17:24:55 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Subject: Re: [Xenomai-help] Xenomai & RTAI question
References: <5eb4b0650603170807x3a5d3d0oecd9e2ce4ba6a29c@domain.hid>
In-Reply-To: <5eb4b0650603170807x3a5d3d0oecd9e2ce4ba6a29c@domain.hid>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: KC <kcc1967@domain.hid>
Cc: xenomai@xenomai.org

KC wrote:
> Hi,
> 
> Just some simple questions,
> 
> - do I need RTAI to run Xenomai ?

No.

> - Can I have RTAI and Xenomai installed together ?

If by "installed" you mean running side-by-side safely, then the answer is no. 
RTAI would need to be fixed not to bypass the Adeos virtualization layer.

> - Is Xenomai a real real-time OS or just a emulator ?
> 

A real-time framework, including a real-time core, to build the real-time OS of 
your dreams, or use a pre-canned one that's already available with it.
Aside of this, I don't understand how one could properly emulate a RTOS without 
any real-time capabilities under the hood. Quite frankly, syntactical 
compatibility using API wrappers without actual behavioural compatibility with the 
source RTOS is just silly marketing mumbo-jumbo in action.

> Thanks
> KC
> 
> _______________________________________________
> Xenomai-help mailing list
> Xenomai-help@domain.hid
> https://mail.gna.org/listinfo/xenomai-help
> 


-- 

Philippe.

