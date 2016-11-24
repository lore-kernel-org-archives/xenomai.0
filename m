References: <DF4PR84MB0299F84DFCDC76FD7D360B12F7B10@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
 <a22149dd-141c-f148-113e-318f542095ae@xenomai.org>
 <DF4PR84MB0299ABE95D22EE2DF3E6F028F7B70@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <c44e8d9f-5be1-ab14-18ad-e67fa8718672@xenomai.org>
Date: Thu, 24 Nov 2016 15:44:28 +0100
MIME-Version: 1.0
In-Reply-To: <DF4PR84MB0299ABE95D22EE2DF3E6F028F7B70@DF4PR84MB0299.NAMPRD84.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] Help needed regarding compiling/installing Xenomai
 patch
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Ramakrishnan, Senthil" <senthil.ramakrishnan@hp.com>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 11/23/2016 06:13 PM, Ramakrishnan, Senthil wrote:
> Dear Philippe,
> 
> Thanks much for the response and you answered all our questions. One more question I have is if there is a Standalone RTDM patch available. Or, if it's possible to apply RTDM changes alone from the Xenomai-Cobalt kernel patch.

There is a prototype implementation of a native RTDM interface at
http://git.xenomai.org/rtdm-native.git/, which dates back to 2007
(Xenomai 2.2 timeframe). This code was neither maintained nor ported to
any later Xenomai release.

You cannot use the Cobalt incarnation of RTDM over Mercury. This
implementation is specific to a dual kernel configuration, based on the
Xenomai kernel API.

-- 
Philippe.

