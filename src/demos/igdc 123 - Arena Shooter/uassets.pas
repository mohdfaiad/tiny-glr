unit uAssets;

interface

uses
  glr_scene,
  glr_math,
  glr_render,
  glr_render2d;

type

  { Assets }

  Assets = class
  public
    // Base assets

    class var GuiAtlas: TglrTextureAtlas;
    class var GuiMaterial: TglrMaterial;
    class var GuiCamera: TglrCamera;
    class var GuiSpriteBatch: TglrSpriteBatch;

    class var FontMain: TglrFont;
    class var FontMainBatch: TglrFontBatch;

    class procedure LoadBase();
    class procedure UnloadBase();

    // Level specified assets
    // ...
  end;

  { Texts }

  Texts = class
  public
    class var
      MenuNewGame, MenuSettings, MenuExit, MenuTitle, MenuAuthorName,

      MenuApply, MenuBack,

      SettingsMusicVolume, SettingsSoundVolume

      : UnicodeString;


    class procedure LoadMenu();
  end;

  { Colors }

  Colors = class
    class var
      Red, White, Black, Gray,

      MenuButton, MenuButtonText, MenuButtonOver,
      MenuSlider, MenuSliderOver,

      MenuText,

      MenuBackground

      : TglrVec4f;

    class procedure Load();
  end;

const
  R_GUI_ATLAS_BUTTON      = 'button.png';
  R_GUI_ATLAS_BUTTON_OVER = 'button_over.png';
  R_GUI_ATLAS_SLIDER_BACK = 'slider_back.png';
  R_GUI_ATLAS_SLIDER_FILL = 'slider_fill.png';
  R_GUI_ATLAS_SLIDER_BTN  = 'slider_btn.png';
  R_GUI_ATLAS_CHECKBOX    = 'checkbox.png';
  R_GUI_ATLAS_CHECKBOX_C  = 'checkbox_check.png';

implementation

uses
  glr_filesystem, glr_core;

const
  R_BASE = 'data/';

  R_GUI_ATLAS_IMG = R_BASE + 'gui.tga';
  R_GUI_ATLAS_TXT = R_BASE + 'gui.atlas';

  R_FONT_MAIN = R_BASE + 'HelveticaLight19b.fnt';

{ Colors }

class procedure Colors.Load;
begin
  Red := Color4ub(241, 0, 0);
  White := Color4ub(255, 255, 255);
  Black := Color4ub(0, 0, 0);
  Gray := Color4ub(60, 60, 60);

  MenuButton      := Red;   //Color4ub(80, 160, 255);
  MenuButtonText  := White; //Color4ub(230, 230, 230);
  MenuButtonOver  := White; //Color4ub(160, 250, 250);
  MenuSlider      := Red;
  MenuSliderOver  := White;
  MenuText        := Red;
  MenuBackground  := Gray; //:= Color4ub(20, 50, 110);
end;

{ Texts }

class procedure Texts.LoadMenu();
begin
  MenuNewGame := UTF8Decode('Новая игра');
  MenuSettings := UTF8Decode('Настройки');
  MenuExit := UTF8Decode('Выход');
  MenuTitle := UTF8Decode('Arena Shooter для igdc #123');
  MenuAuthorName := UTF8Decode('perfect.daemon, 2015 (c)');

  MenuApply := UTF8Decode('Применить');
  MenuBack  := UTF8Decode('Назад');

  SettingsMusicVolume := UTF8Decode('Музыка');
  SettingsSoundVolume := UTF8Decode('Звуки');
end;

{ Assets }

class procedure Assets.LoadBase();
begin
  GuiAtlas := TglrTextureAtlas.Create(
    FileSystem.ReadResource(R_GUI_ATLAS_IMG),
    FileSystem.ReadResource(R_GUI_ATLAS_TXT),
    extTga, aextCheetah);

  GuiMaterial := TglrMaterial.Create(Default.SpriteShader);
  GuiMaterial.AddTexture(GuiAtlas, 'uDiffuse');

  GuiSpriteBatch := TglrSpriteBatch.Create();

  GuiCamera := TglrCamera.Create();
  GuiCamera.SetProjParams(0, 0, Render.Width, Render.Height, 45, 0.1, 100, pmOrtho, pTopLeft);
  GuiCamera.SetViewParams(
    Vec3f(0, 0, 100),
    Vec3f(0, 0, 0),
    Vec3f(0, 1, 0));

  FontMain := TglrFont.Create(FileSystem.ReadResource(R_FONT_MAIN));
  FontMainBatch := TglrFontBatch.Create(FontMain);
end;

class procedure Assets.UnloadBase();
begin
  GuiMaterial.Free();
  GuiAtlas.Free();

  GuiSpriteBatch.Free();

  GuiCamera.Free();

  FontMainBatch.Free();
  FontMain.Free();
end;

end.

