References: <DB6PR0701MB2456FE5A9F080B3BE39375E0B5A40@DB6PR0701MB2456.eurprd07.prod.outlook.com>
 <08c2ad36-f2c4-952f-5372-bd95146943cf@xenomai.org>
 <DB6PR0701MB24560C064C4B2E0CA3E8BA72B5BB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <16992f8a-acba-371e-bd48-b515d60978ff@xenomai.org>
Date: Thu, 5 Apr 2018 15:25:40 +0200
MIME-Version: 1.0
In-Reply-To: <DB6PR0701MB24560C064C4B2E0CA3E8BA72B5BB0@DB6PR0701MB2456.eurprd07.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] doc for xeno-config skins
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Giulio Moro <g.moro@qmul.ac.uk>, "xenomai@xenomai.org" <xenomai@xenomai.org>

On 04/05/2018 01:39 PM, Giulio Moro wrote:
> Thanks and sorry for overlooking that. I thought if there was some docs on xeno-config it would have been inlined in its source, so that is where I looked for it. I guess the man folder should have been a more obvious choice.
> 
> Is it correct that calling `xeno-config --skin cobalt` expects you to call, POSIX functions prefixed with `__wrap_` ? Does this mean that the *actual* "Cobalt POSIX interface" consists of __wrap_fn() calls as opposed to fn() calls?

__RT(fn()) and __COBALT(fn()) hide this ugly __wrap prefix inside an
ugly macro. __STD() keeps consistent with such ugliness for __real calls.

> If yes,  is this documented somewhere obvious?
 I kind of figured this out over time by reading
http://xenomai.org/2014/08/porting-a-linux-application-to-xenomai-dual-kernel/
 and looking at the wrappers files and at the source code, but is it
stated clearly somewhere?

Of course not. Proper documentation hinders fruitful imagination.

> This is a place where I would have looked for that, for instance: http://www.xenomai.org/documentation/xenomai-3/html/xeno3prm/group__cobalt__api.html .
> 

Makes sense, added to my todo list. This is part of a larger
documentation work.

> (incidentally, these two images (referenced by the xeno-config man page) are missing
> http://www.xenomai.org/documentation/xenomai-3/html/man1/asciidoc-icons/note.png
> http://www.xenomai.org/documentation/xenomai-3/html/man1/asciidoc-icons/caution.png
> )
>

Ok, thanks.

-- 
Philippe.

