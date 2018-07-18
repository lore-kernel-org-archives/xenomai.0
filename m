From: Leopold Palomo-Avellaneda <leo@alaxarxa.net>
Message-ID: <6cfe07fb-23f1-4dc9-7e27-c264cedd4281@alaxarxa.net>
Date: Wed, 18 Jul 2018 13:37:59 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: [Xenomai] Cards paramenter in rtnet
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: "Xenomai@xenomai.org" <xenomai@xenomai.org>

Hi,


I have used the cards parameter to load a rtnet driver to select which card I
would like to use with rtnet. However, in 3.0.7 I have found this message:

rt_e1000e: unknown parameter 'cards' ignored

Here [1], is documented the use of this parameter, so I guess that is not
deprecated. But I have also found this unknown option for me: REBIND_RT_NICS.

So, what is the best option to load a rtnet driver and select which card do you
want to use?

Best regards,


Leopold


[1] https://gitlab.denx.de/Xenomai/xenomai/wikis/RTnet_Setup
-- 
--
Linux User 152692     GPG: 05F4A7A949A2D9AA
Catalonia
-------------------------------------
A: Because it messes up the order in which people normally read text.
Q: Why is top-posting such a bad thing?
A: Top-posting.
Q: What is the most annoying thing in e-mail?

