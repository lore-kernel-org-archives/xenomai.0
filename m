Message-ID: <53F363D8.7060906@xenomai.org>
Date: Tue, 19 Aug 2014 16:48:56 +0200
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
References: <lsuquk$cpv$1@ger.gmane.org>
In-Reply-To: <lsuquk$cpv$1@ger.gmane.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Xenomai 3 ready for use
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <http://www.xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://www.xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <http://www.xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Wolfram Wadepohl <Wolfram.Wadepohl@ek-automation.com>, xenomai@xenomai.org

On 08/19/2014 08:30 AM, Wolfram Wadepohl wrote:
> Hi all,
> 
> I'm now starting a new project for an automation control. Should I go
> Xenomai 3, which isn't in the 'stable' state yet, or should I go with
> 2.x and migrate later to Xenomai 3? Please advice. Thanks.
> 

There are many aspects to ponder which basically depend on your project
(timeline, lifetime, features, hardware architecture, maintenance
policy, planned evolution etc). This makes the question quite difficult
to answer in these terms for anyone but you and your team.

A few hints though:

- this migration guide from 2.x to 3.x may give you some useful
information: http://xenomai.org/migrating-from-xenomai-2-x-to-3-x/

- we are about to enter the -rc cycle for Xenomai 3.

-- 
Philippe.

