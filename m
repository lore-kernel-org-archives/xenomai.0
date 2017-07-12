References: <13c4f7b0-0d88-d98b-3963-6337f3386632@cs.ru.nl>
From: Philippe Gerum <rpm@xenomai.org>
Message-ID: <6f369425-ae88-2124-a386-83f95df00067@xenomai.org>
Date: Wed, 12 Jul 2017 16:28:36 +0200
MIME-Version: 1.0
In-Reply-To: <13c4f7b0-0d88-d98b-3963-6337f3386632@cs.ru.nl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Xenomai] strerror or symerror
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Harco Kuppens <h.kuppens@cs.ru.nl>, xenomai@xenomai.org

On 07/11/2017 04:54 PM, Harco Kuppens wrote:
> 
> When looking at some of the test programs coming with xenomai 3  I
> noticed that they use symerror instead of strerror.
> e.g. in ./testsuite/gpiotest/gpiotest.c
> 
> I saw that within xenomai symerror is defined in
> ./lib/boilerplate/ancillaries.c, and is xenomai specific.
> 
> Should I use symerror instead of strerror in realtime code?
> 
> 

As you can see, symerror() is a small helper returning the error label
in compact ascii form, unlike the textual description strerror() provides.

Since strerror() is influenced by the current locale, I would not expect
it to stay in primary mode unconditionally; symerror() is guaranteed to
never migrate.

-- 
Philippe.

