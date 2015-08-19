References: <1529421239.7462838.1439985533416.JavaMail.yahoo@mail.yahoo.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <55D4AF9E.4010302@xenomai.org>
Date: Wed, 19 Aug 2015 18:32:30 +0200
MIME-Version: 1.0
In-Reply-To: <1529421239.7462838.1439985533416.JavaMail.yahoo@mail.yahoo.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [Xenomai] enabling Xenomai 2.x on udoo
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: =?UTF-8?B?4oCrTW9oYW1lZCBGYXd6eeKArCDigKs=?= <m.fawzy307@yahoo.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 08/19/2015 01:58 PM, ‫Mohamed Fawzy‬ ‫ wrote:
> i followed  documentation to  get xenomai up and running on a udoo board 
> but when i run the latency test i get this error message : Xenomai: native skin or CONFIG_XENO_OPT_PERVASIVE disabledwhen i check  Troubleshooting guide i found that i should have /proc/xenomai/version but in my udooubuntu the folder proc is empty 
> please i need your help to fix this problem and how i can check that xenomai is running on my board 

You already did, it does not. The help text you mention also recommends
to check for errors in your kernel log. Did you do that?

This URL provides hints about the best way to get useful answers to
questions:
http://xenomai.org/start-here/#If_something_goes_wrong

PS: please make sure to provide a valid subject line, a blank one does
not help for threading.

-- 
Philippe.

