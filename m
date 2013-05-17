Message-ID: <51967FC3.9020409@xenomai.org>
Date: Fri, 17 May 2013 21:06:43 +0200
From: Gilles Chanteperdrix <gilles.chanteperdrix@xenomai.org>
MIME-Version: 1.0
References: <CAMDpcBGxGUCtcnREr9AeQihhiNO8D7vvxbFCa7647fOO4rMzow@mail.gmail.com>	<51960FB1.9030400@xenomai.org>	<CAMDpcBF84ZRLG=eeyhus5qE5+t5Smf_jETtVGUSC9r7iu62ARg@mail.gmail.com>
	<CAMDpcBF-EkDjQyXNY2OLeDTSEgPujBEr3Y1BNL27AEYRaJ068Q@mail.gmail.com>
In-Reply-To: <CAMDpcBF-EkDjQyXNY2OLeDTSEgPujBEr3Y1BNL27AEYRaJ068Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] <6>Xenomai: scheduling class idle registered.
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
	<mailto:xenomai-request@xenomai.org?subject=subscribe>
To: kunming yang <yangkunming99@gmail.com>
Cc: xenomai@xenomai.org

On 05/17/2013 03:34 PM, kunming yang wrote:

> Hello Gilles,
> 
> Is it ok that I configure the timer which is used for OS to generate a
> periodic interrupt as xenomai clock? (Timer2 in my case)


No, Xenomai needs a one-shot timer, not a periodic timer, see:
http://www.xenomai.org/index.php/I-pipe-core:ArmPorting#The_general_case

-- 
                                                                Gilles.

