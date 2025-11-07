{if $is_auth}
    {$user = \RS\Application\Auth::getCurrentUser()}
    {if $user['is_admin']}
        <header>
            <nav>
                <a href="/" class="logo"></a>
                <a href="/invoices/" class="navi-link">Выставление счетов</a>
                <a href="/print/" class="navi-link">Печать документов</a>
                <a href="/payments/" class="navi-link">История платежей</a>
                <a href="/statistics/" class="navi-link">Статистика</a>
                <a href="/reports.html" class="navi-link">Отчёты</a>
                <div class="separator"></div>
                <div class="actions">
                    <a href="{$router->getUrl('users-front-auth', ['Act' => 'logout'])}" class="logout-btn">Выход</a>
                    <a href="#mobile-menu" class="sidenav-trigger">
                        <i class="mdi mdi-menu"></i>
                    </a>
                </div>
            </nav>
        </header>
        <ul class="sidenav" id="mobile-menu">
            <li><a href="/">Реестр договоров</a></li>
            <li><a href="/invoices/">Выставление счетов</a></li>
            <li><a href="/print/">Печать документов</a></li>
            <li><a href="/payments/">Платежи</a></li>
            <li><a href="/stats.html">Статистика</a></li>
            <li><a href="/reports.html">Отчёты</a></li>
        </ul>
    {else}
        <header>
            <nav>
                <a href="/" class="logo"></a>
                <a href="/renter-invoice/" class="navi-link">Счета</a>
                <a href="/renter-payment/" class="navi-link">Оплаты</a>
                <div class="actions">
                    <a href="{$router->getUrl('users-front-auth', ['Act' => 'logout'])}" class="logout-btn">Выход</a>
                    <a href="#mobile-menu" class="sidenav-trigger">
                        <i class="mdi mdi-menu"></i>
                    </a>
                </div>
            </nav>
        </header>
        <ul class="sidenav" id="mobile-menu">
            <li><a href="/renter-invoice/">Счета</a></li>
            <li><a href="/renter-payment/">Оплаты</a></li>
        </ul>
    {/if}    
    {block name="content"}
        {$app->blocks->getMainContent()}
    {/block}    
{else}
    <header class="no-auth">
        <nav>
            <a href="/" class="logo"></a>
        </nav>
    </header>
    <main>
        <div class="global-wrapper" id="user-auth-wrapper">
            <div class="user-auth">
                <div class="auth-header">
                    <p>Для дальнейшего просмотра необходимо авторизоваться</p>
                    <h1>Авторизация</h1>
                    {if $error}<span class="formFieldError">{$error}</span>{/if}
                </div>

                {if !empty($status_message)}<div class="page-error">{$status_message}</div>{/if}

                <form method="POST" action="{$router->getUrl('users-front-auth')}">
                    {hook name="users-authorization:form" title="{t}Авторизация:форма{/t}"}
                    {$this_controller->myBlockIdInput()}
                        <input type="hidden" name="referer" value="/">
                        <input type="hidden" name="remember" value="1" checked>
                        <div class="row">
                            <div class="input-field">
                                <input type="text" placeholder="Имя пользователя" name="login" value="{$data.login|default:$Setup.DEFAULT_DEMO_LOGIN}" class="styled {if !empty($error)}has-error{/if}" autocomplete="off">
                                <label>Имя пользователя</label>

                            </div>
                        </div>
                        <div class="row">
                            <div class="input-field">
                                <input type="text" placeholder="{t}Пароль{/t}" name="pass" value="{$Setup.DEFAULT_DEMO_PASS}" class="styled {if !empty($error)}has-error{/if}" autocomplete="off">
                                <label>Пароль</label>
                            </div>
                        </div>




                        <div class="form__menu_buttons mobile-flex right-align">
                            <button type="submit" class="link link-more btn">{t}Войти{/t}</button>
                        </div>
                    {/hook}
                </form>


           </div>
        </div>
    </main>
{/if}
