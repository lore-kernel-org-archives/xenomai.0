Message-ID: <2ff1a98a0712030516p3222d1e4yf45b44f9ae23f48a@domain.hid>
Date: Mon, 3 Dec 2007 14:16:32 +0100
From: "Gilles Chanteperdrix" <gilles.chanteperdrix@xenomai.org>
In-Reply-To: <5a4b7020712030458i7e450b0cq3b1b72d1068f82f9@domain.hid>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5a4b7020712030458i7e450b0cq3b1b72d1068f82f9@domain.hid>
Subject: Re: [Xenomai-help] mlockall MCL_FUTURE
List-Id: Help regarding installation and common use of Xenomai
	<xenomai.xenomai.org>
List-Unsubscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
List-Archive: </public/xenomai-help>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-help-request@domain.hid>
List-Subscribe: <https://mail.gna.org/listinfo/xenomai-help>,
	<mailto:xenomai-help-request@domain.hid>
To: jie zhang <xenomai.rtai@domain.hid>
Cc: xenomai@xenomai.org

On Dec 3, 2007 1:58 PM, jie zhang <xenomai.rtai@domain.hid> wrote:
> Hi
>  I have a question about mlockall, there is a parameter named MCL_FUTURE in
> mlockall,  I just want to know in what situation should MCL_FUTURE should be
> used, I just know this parameter will lock all the memory this application
> used in future, and then it will avoid page-fault, so in this case does the
> following two situation are same?
>
> mlockall(MCL_FUTURE| ...
>   get resources
>   enter rt-context
>
> or?
>
>   get all resources
>   mlockall(MCL_CURRENt
>   enter rt-context

The usual idiom is to call mlockall(MCL_CURRENT|MCL_FUTURE), and this
must be done before you enter rt context.

-- 
                                               Gilles Chanteperdrix

