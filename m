Subject: Re: [PATCH] Remove analogy support
References: <27482c83-6428-30df-52a6-b2fa9c61c98b@siemens.com>
 <76895dcc-ef00-b24a-9b00-c928425a2148@akamina.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Message-ID: <05cdf5a9-e599-82f3-ad57-8f3fe7677990@siemens.com>
Date: Tue, 13 Jul 2021 16:08:24 +0200
MIME-Version: 1.0
In-Reply-To: <76895dcc-ef00-b24a-9b00-c928425a2148@akamina.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
List-Id: Discussions about the Xenomai project <xenomai.xenomai.org>
List-Unsubscribe: <https://xenomai.org/mailman/options/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=unsubscribe>
List-Archive: <http://xenomai.org/pipermail/xenomai/>
List-Post: <mailto:xenomai@xenomai.org>
List-Help: <mailto:xenomai-request@xenomai.org?subject=help>
List-Subscribe: <https://xenomai.org/mailman/listinfo/xenomai>,
 <mailto:xenomai-request@xenomai.org?subject=subscribe>
To: Peter Laurich <Peter.Laurich@akamina.com>, xenomai@xenomai.org

On 13.07.21 15:57, Peter Laurich via Xenomai wrote:
> Hi,
> 
> I noticed this patch being submitted and was caught a bit off-guard by
> the situation. How long has it been since Analogy was actively
> maintained? A lot of the drivers that I have developed use the Analogy
> API to pass information between acquisition hardware and user-space code.
> 

Hah, finally a reaction, after so many calls! :)

Well, the last driver change not fixing forward-porting issues or
adjusting to refactorings was this one, I think:

commit 328b0447cfa282fbe926ebbd9113224e4a1c18b9
Author: Jorge Ramirez-Ortiz <jorge.ramirez-ortiz@linaro.org>
Date:   Thu Aug 13 10:23:16 2015 -0400

    drivers/analogy: release pci region if mapping failed

So, almost 6 years ago. No one cared since then, neither by adding new
drivers or features, nor by fixing issues that should have been visible
by using things (only issues found by chance when looking at or
compiling of code).

Are you still actively using analogy? Or are you considering to?

Jan

-- 
Siemens AG, T RDA IOT
Corporate Competence Center Embedded Linux

